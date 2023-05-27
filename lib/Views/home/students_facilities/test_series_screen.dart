import 'dart:convert';
import 'dart:io';
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
        "https://trusher.shellcode.co.in/api/testSeriese?authKey=${GlobalData.auth1}&student_id=${GlobalStudent.id}"));
    tests = json.decode(response.body);
    if (response.statusCode == 200) {
      print(tests);
    } else {
      print("Unsuccessful");
    }
  }

  int touched = 0;

  Future<void> postData() async {
    setState(() {
      showSpinner = true;
    });

    var uri = Uri.parse("https://trusher.shellcode.co.in/api/uploadTest?");

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

  Map<String, dynamic> tests = {};

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
            if (tests.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator(color: primary2));
            } else {
              return tests["data"].length == 0
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
                              int y = int.parse(tests["data"][i]["shadule_date"]
                                  .substring(0, 4));
                              int m = int.parse(tests["data"][i]["shadule_date"]
                                  .substring(5, 7));
                              int d = int.parse(tests["data"][i]["shadule_date"]
                                  .substring(8, 10));
                              final now = DateTime.now();
                              final today =
                                  DateTime(now.year, now.month, now.day);
                              final testDate = DateTime.parse(tests["data"][i]
                                      ["shadule_date"] +
                                  " 23:59:59");
                              int nowd = now.day;
                              int nowm = now.month;
                              int nowy = now.year;

                              bool visibility = testDate.isAfter(now);

                              return Visibility(
                                visible: visibility,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      ind = i;
                                      touched = i;
                                      test_id =
                                          tests["data"][i]["id"].toString();
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: 5.h,
                                        left: 3.h,
                                        right: 3.h,
                                        top: 2.h),
                                    width: 97.w,
                                    // decoration: k3DboxDecorationWithColor(
                                    //     42,
                                    //     i == ind
                                    //         ? Color.fromARGB(255, 188, 119, 223)
                                    //         : Colors.white),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(42),
                                      color: white,
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.6),
                                        width: 1,
                                      ),
                                      boxShadow: const [
                                        // BoxShadow(
                                        //   spreadRadius: 2,
                                        //   color: Colors.black38,
                                        //   offset: Offset(3, 3),
                                        // ),
                                        BoxShadow(
                                          color: Colors.black38,
                                          spreadRadius: 2,
                                          blurRadius: 2.0,
                                          offset: Offset(4, 7),
                                        ),
                                      ],
                                    ),

                                    padding: EdgeInsets.only(
                                        left: 3.w,
                                        right: 3.w,
                                        top: 2.h,
                                        bottom: 2.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              addHorizontalySpace(4),
                                              Text(
                                                "Test",
                                                style: kBodyText16wBold(black),
                                              ),
                                              addHorizontalySpace(10),
                                              addHorizontalySpace(10),
                                              Container(
                                                width: 15,
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  color: ind == i
                                                      ? const Color.fromARGB(
                                                          255, 104, 217, 123)
                                                      : Colors.transparent,
                                                  shape: BoxShape.circle,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        addVerticalSpace(7),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.all(3),
                                            padding: EdgeInsets.only(
                                              left: 2.w,
                                              // right: 5.w,
                                              top: 2.h,
                                              bottom: 2.h,
                                            ),
                                            decoration: kGradientBoxDecoration(
                                                35, purpleGradident()),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 28.w,
                                                  child: Image.asset(
                                                      'assets/images/test.png'),
                                                ),
                                                addHorizontalySpace(10),
                                                Container(
                                                  // height: 14.h,
                                                  width: 40.w,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(
                                                          tests["data"][i]
                                                              ["subject"],
                                                          style:
                                                              kBodyText20wBold(
                                                                  white),
                                                        ),
                                                      ),
                                                      Text(
                                                        tests["data"][i]
                                                            ["chapter"],
                                                        style:
                                                            kBodyText14wNormal(
                                                                white),
                                                      ),
                                                      addVerticalSpace(10),
                                                      Text(
                                                        tests["data"][i]
                                                            ["shadule_date"],
                                                        style:
                                                            kBodyText14wNormal(
                                                                white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        addVerticalSpace(3.h),
                                        InkWell(
                                          onTap: () async {
                                            if (touched == i) {
                                              final pickedFile =
                                                  await _picker.pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 80,
                                              );

                                              if (pickedFile != null) {
                                                image = File(pickedFile.path);
                                                Get.snackbar(
                                                  "Success",
                                                  "Image Selected",
                                                  backgroundColor: Colors.green
                                                      .withOpacity(0.65),
                                                );
                                                setState(() {
                                                  showSpinner = false;
                                                });
                                              } else {
                                                Get.snackbar(
                                                  "Error",
                                                  "Image Not Selected",
                                                  backgroundColor: Colors.red
                                                      .withOpacity(0.65),
                                                );
                                                print("No image selected");
                                              }
                                            }
                                          },
                                          child: Container(
                                            // height: 17.h,
                                            width: width(context) * 0.92,
                                            height: 20.h,
                                            decoration: k3DboxDecoration(38),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                  child: Image.asset(
                                                    'assets/images/upload.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                addVerticalSpace(1.5.h),
                                                Text(
                                                  'Upload File',
                                                  style:
                                                      kBodyText16wNormal(black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        addVerticalSpace(3.h),
                                      ],
                                    ),
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
          visible: true,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomButton(
                text: 'Send',
                onTap: () {
                  if (tests["uploaded"].length == 0) {
                    if (test_id != "-1") {
                      if (image != null) {
                        postData();
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
