import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../global_data/GlobalData.dart';
import '../../../global_data/student_global_data.dart';
import '../../../utils/constants.dart';
import '../../../widget/image_opener.dart';

class TestSeriesScreen extends StatefulWidget {
  const TestSeriesScreen({super.key});

  @override
  State<TestSeriesScreen> createState() => _TestSeriesScreenState();
}

class _TestSeriesScreenState extends State<TestSeriesScreen> {
  bool isPaperChecked = false;
  final ImagePicker _picker = ImagePicker();
  bool showSpinner = false;

  File? image;

  Future<void> getTest() async {
    final http.Response response = await http.get(Uri.parse(
        "${GlobalData.baseUrl}/courses?authKey=${GlobalData.auth1}&user_id=${GlobalStudent.id}&class=${GlobalStudent.specificProfile["data"][0]["class"]}&medium=${GlobalStudent.specificProfile["data"][0]["medium"]}"));
    courses = json.decode(response.body);
    if (response.statusCode == 200) {
      log(courses.toString());
    } else {
      print("Unsuccessful");
    }
  }

  int touched = 0;

  Future<void> postData(int teacherId) async {
    setState(() {
      showSpinner = true;
    });

    var uri = Uri.parse("${GlobalData.baseUrl}/uploadTest?");

    var request = http.MultipartRequest('POST', uri);

    request.fields['authKey'] = GlobalData.auth1;
    request.fields['student_id'] = GlobalStudent.id.toString();
    request.fields['test_id'] = test_id.toString();

    var multiPart;

    if (image != null) {
      var stream = http.ByteStream(image!.openRead());
      stream.cast();
      var len = await image!.length();
      multiPart = http.MultipartFile(
        'image',
        () async* {
          yield* image!.openRead();
        }(),
        len,
        filename: image!.path,
      );
      request.files.add(multiPart);
    }

    try {
      http.StreamedResponse response;

      Future.delayed(Duration(seconds: 6), () async {});
      response = await request.send();

      if (response.statusCode == 200) {
        var httpResponse = await http.Response.fromStream(response);
        Map<String, dynamic> jsonResponse = json.decode(httpResponse.body);
        print(jsonResponse);
        String msg = jsonResponse["Message"].toString();
        if (msg == "Report add successfully") {
          setState(() {
            showSpinner = false;
            Get.snackbar(
              "Done",
              "Test Uploaded",
              backgroundColor: Colors.green.withOpacity(0.65),
            );
          });
        } else {
          setState(() {
            showSpinner = false;
          });
          // nextScreen(context, ErrorScreen(message: msg));
        }
      } else {
        setState(() {
          showSpinner = false;
        });
        Get.snackbar(
          "Error",
          "Try again",
          backgroundColor: Colors.red.withOpacity(0.65),
        );
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Try again",
        backgroundColor: Colors.red.withOpacity(0.65),
      );
      setState(() {
        showSpinner = false;
      });
      print('API request failed with exception: $e');
    }
    setState(() {
      showSpinner = false;
    });
  }

  Map<String, dynamic> courses = {};

  int ind = -1;
  String test_id = "-1";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: customAppbar2(context, 'Test Series'),
        body: FutureBuilder(
          future: getTest(),
          builder: (context, snapshot) {
            if (courses.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator(color: primary2));
            } else {
              return courses["data"].length == 0
                  ? const Center(
                      child: Text('Tests will soon be uploaded'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          addVerticalSpace(1.h),
                          ListView.builder(
                            // itemCount: tests["data"].length,
                            itemCount: 1,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, i) {
                              return GestureDetector(
                                onTap: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'pdf',
                                      'doc',
                                      'docx',
                                      'zip'
                                    ],
                                  );

                                  if (result != null &&
                                      result.files.isNotEmpty) {
                                    image = File(result.files.single.path!);
                                    postData(
                                        courses["mycourse"][i]["course_name"]);

                                    // Do something with the picked document
                                    // For example, print the file path
                                    print(image!.path);
                                  } else {}
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 1.5.h),
                                  // height: 11.h,
                                  width: 93.w,
                                  decoration: kGradientBoxDecoration(
                                      35, purpleGradident()),
                                  // decoration: kFillBoxDecoration(0, Color(0xff48116a), 35),

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 60.w,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                courses["mycourse"][i]
                                                    ["course_name"],
                                                style: kBodyText24wBold(white),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          addHorizontalySpace(5.w),
                                        ],
                                      ),
                                      Text(
                                        'Course started on: ${courses["mycourse"][i]["dt"].toString().substring(0, courses["mycourse"][i]["dt"].indexOf(" "))}',
                                        style: kBodyText15wNormal(white),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
            }
          },
        ),
        bottomNavigationBar: Visibility(
          visible: false,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomButton(
                text: 'Send',
                onTap: () {
                  if (true) {
                    if (test_id != "-1") {
                      if (image != null) {
                        // if (tests["uploaded"].length == 0) {
                        //   if (test_id != "-1") {
                        //     if (image != null) {
                      } else {
                        Get.snackbar(
                          "Image not selected",
                          "Select an image to upload",
                          backgroundColor: Colors.red.withOpacity(0.65),
                        );
                      }
                    } else {
                      Get.snackbar(
                        "Select a test to proceed",
                        "Select a test",
                        backgroundColor: Colors.yellow.withOpacity(0.65),
                      );
                    }
                  }
                }),
          ),
        ),
      ),
    );
  }
}
