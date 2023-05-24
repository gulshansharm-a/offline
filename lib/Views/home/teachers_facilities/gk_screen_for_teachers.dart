import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:offline_classes/global_data/teacher_global_data.dart';
import 'package:offline_classes/model/statics_list.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../global_data/GlobalData.dart';
import '../../../global_data/student_global_data.dart';
import '../../../widget/custom_textfield.dart';
import '../../enquiry_registrations/error_screen.dart';

class GKScreenForTeacher extends StatelessWidget {
  GKScreenForTeacher({super.key});

  Future<void> getGK() async {
    final http.Response response = await http.get(Uri.parse(
        "https://trusher.shellcode.co.in/api/gk?authKey=${GlobalData.auth1}&user_id=${GlobalTeacher.id}"));
    gk = json.decode(response.body);
    if (response.statusCode == 200) {
      print(gk);
    } else {
      print("Unsuccessful");
    }
  }

  Map<String, dynamic> gk = {};

  @override
  Widget build(BuildContext context) {
    print(GlobalTeacher.id);
    print(gk);
    return FutureBuilder(
      future: getGK(),
      builder: (context, snapshot) {
        if (gk.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(color: primary2));
        } else {
          return Scaffold(
            appBar: customAppbar2(context, 'General Knowledge'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  addVerticalSpace(1.h),
                  Center(
                    child: Text(
                      'For All Classes',
                      style: kBodyText18wBold(black),
                    ),
                  ),
                  ListView.builder(
                    itemCount: gk["allgk"].length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, i) {
                      return Container(
                        margin: EdgeInsets.all(2.h),
                        width: 93.w,
                        decoration: k3DboxDecoration(42),
                        padding: EdgeInsets.only(
                            left: 9.w, right: 5.w, top: 2.h, bottom: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              gk["allgk"][i]["tittle"],
                              style: kBodyText18wNormal(black),
                            ),
                            addVerticalSpace(1.h),
                            Text(
                              gk["allgk"][i]["disc"],
                              style: kBodyText14w500(black),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomButton(
                  text: 'Add General Knowledge',
                  onTap: () {
                    nextScreen(context, AddGKContent(category: "gkall"));
                  }),
            ),
          );
        }
      },
    );
  }
}

class AddGKContent extends StatefulWidget {
  AddGKContent({super.key, this.student_id = -1, required this.category});

  int student_id = -1;
  final String category;

  @override
  State<AddGKContent> createState() => _AddGKContentState();
}

class _AddGKContentState extends State<AddGKContent> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  File? image;

  bool showSpinner = false;

  Future<void> postData() async {
    setState(() {
      showSpinner = true;
    });

    var uri = Uri.parse("https://trusher.shellcode.co.in/api/addGk?");

    var request = http.MultipartRequest('POST', uri);

    request.fields['authKey'] = GlobalData.auth1;
    request.fields['teacher_id'] = GlobalTeacher.id.toString();
    request.fields['title'] = title.text.toString().trim();
    request.fields['discription'] = description.text.trim();
    request.fields['category'] = widget.category;

    if (widget.student_id > 0) {
      request.fields['student_id'] = widget.student_id.toString();
    }

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
      var response = await request.send();

      if (response.statusCode == 200) {
        var httpResponse = await http.Response.fromStream(response);
        var jsonResponse = json.decode(httpResponse.body);
        print(jsonResponse);
        String msg = jsonResponse["Message"].toString();
        if (msg == "Gk added successfully") {
          setState(() {
            showSpinner = false;
          });
          Get.snackbar("Done", "GK added successfully");
        } else {
          setState(() {
            showSpinner = false;
          });
          nextScreen(context, ErrorScreen(message: msg));
        }
      } else {
        setState(() {
          showSpinner = false;
        });
        Get.snackbar("Error", "Try again later");
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar("Error", "Try again later");
      setState(() {
        showSpinner = false;
      });
      print('API request failed with exception: $e');
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppbar2(context, 'Add General Knowledge'),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(2.h),
              CustomTextfield(
                hintext: 'Title',
                controller: title,
              ),
              addVerticalSpace(3.h),
              CustomTextfieldMaxLine(
                hintext: 'Description',
                controller: description,
              ),
              addVerticalSpace(3.h),
              InkWell(
                onTap: () {
                  setState(() {
                    selectFile(context, image, showSpinner);
                  });
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(left: 7),
                  height: 6.h,
                  width: 35.w,
                  decoration: k3DboxDecoration(10),
                  // padding: EdgeInsets.only(top: )
                  // ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_link,
                        color: image != null ? Colors.transparent : textColor,
                      ),
                      addHorizontalySpace(6),
                      Text(
                        image == null ? 'Attach File' : 'File attached',
                        style: kBodyText14w500(textColor),
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(6),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Attach PDF, JPEG, PNG',
                  style: kBodyText10wBold(black),
                ),
              ),
              Spacer(),
              CustomButton(
                text: 'Post',
                onTap: () {
                  if (title.text.toString().isNotEmpty &&
                      description.text.toString().isNotEmpty) {
                    postData();
                  } else {
                    Get.snackbar("Please fill the fields",
                        "Title and description are required");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> selectFile(BuildContext context, File? image, bool) {
    ImagePicker _picker = ImagePicker();
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: const EdgeInsets.all(6),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return Container(
              height: height * 0.35,
              // decoration: kFillBoxDecoration(0, white, 40),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Select a File',
                    style: kBodyText18wBold(black),
                  ),
                  addVerticalSpace(5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          try {
                            final pickedFile = await _picker.pickImage(
                              source: ImageSource.camera,
                              imageQuality: 80,
                            );

                            if (pickedFile != null) {
                              image = File(pickedFile.path);
                              Get.snackbar("Success", "Image Selected");
                              setState(() {
                                showSpinner = false;
                              });
                            } else {
                              Get.snackbar("Error", "Image Not Selected");
                              print("No image selected");
                            }
                          } catch (e) {
                            Get.snackbar("Access Denied", "");
                          }
                        },
                        child: Container(
                          height: 12.h,
                          width: 30.w,
                          decoration:
                              kGradientBoxDecoration(10, purpleGradident()),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  height: 5.h,
                                  child:
                                      Image.asset('assets/images/camera.png')),
                              Text(
                                'Camera',
                                style: kBodyText12wBold(white),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 80,
                          );

                          if (pickedFile != null) {
                            image = File(pickedFile.path);
                            Get.snackbar("Success", "Image Selected");
                            setState(() {
                              showSpinner = false;
                            });
                          } else {
                            Get.snackbar("Error", "Image Not Selected");
                            print("No image selected");
                          }
                        },
                        child: Container(
                          height: 12.h,
                          width: 30.w,
                          decoration:
                              kGradientBoxDecoration(10, purpleGradident()),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  height: 7.h,
                                  child:
                                      Image.asset('assets/images/gallary.png')),
                              Text(
                                'Gallary',
                                style: kBodyText12wBold(white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(4.h),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        setState;
                      },
                      child: InkWell(
                        onTap: () => goBack(context),
                        child: Text(
                          'Upload',
                          style: kBodyText16wBold(primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
