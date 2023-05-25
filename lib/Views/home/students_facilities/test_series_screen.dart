import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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

  Map<String, dynamic> tests = {};

  int ind = 0;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: FutureBuilder(
        future: getTest(),
        builder: (context, snapshot) {
          if (tests.isEmpty) {
            return const Center(
                child: CircularProgressIndicator(color: primary2));
          } else {
            return Scaffold(
              appBar: customAppbar2(context, 'Test Series'),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    addVerticalSpace(1.h),
                    ListView.builder(
                      itemCount: tests["data"].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        int y = int.parse(
                            tests["data"][i]["shadule_date"].substring(0, 4));
                        int m = int.parse(
                            tests["data"][i]["shadule_date"].substring(5, 7));
                        int d = int.parse(
                            tests["data"][i]["shadule_date"].substring(8, 10));
                        final now = DateTime.now();
                        final today = DateTime(now.year, now.month, now.day);
                        final testDate = DateTime.parse(
                            tests["data"][i]["shadule_date"] + " 23:59:59");
                        int nowd = now.day;
                        int nowm = now.month;
                        int nowy = now.year;
                        print(now);
                        print(testDate);
                        bool visibility = testDate.isAfter(now);
                        print(visibility);
                        // bool visibility = (k == 0 || k == 1) ? true : false;
                        return Visibility(
                          visible: visibility,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                ind = i;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(1.h),
                              width: 97.w,
                              decoration: k3DboxDecorationWithColor(
                                  42,
                                  i == ind
                                      ? Color.fromARGB(255, 192, 214, 231)
                                      : Colors.white),
                              padding: EdgeInsets.only(
                                  left: 3.w, right: 3.w, top: 2.h, bottom: 2.h),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Text(
                                    "Test",
                                    style: kBodyText16wBold(black),
                                  )),
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
                                            // height: 14.h,
                                            width: 65.w,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  tests["data"][i]["subject"],
                                                  style: kBodyText22bold(white),
                                                ),
                                                Text(
                                                  tests["data"][i]["chapter"],
                                                  style:
                                                      kBodyText14wNormal(white),
                                                ),
                                                addVerticalSpace(10),
                                                Text(
                                                  tests["data"][i]
                                                      ["shadule_date"],
                                                  style:
                                                      kBodyText14wNormal(white),
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
                                      final pickedFile =
                                          await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 80,
                                      );

                                      if (pickedFile != null) {
                                        image = File(pickedFile.path);
                                        Get.snackbar(
                                            "Success", "Image Selected");
                                        setState(() {
                                          showSpinner = false;
                                        });
                                      } else {
                                        Get.snackbar(
                                            "Error", "Image Not Selected");
                                        print("No image selected");
                                      }
                                    },
                                    child: Container(
                                      // height: 17.h,
                                      width: width(context) * 0.92,
                                      decoration: k3DboxDecoration(38),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                              // height: 10.h,
                                              child: Image.asset(
                                                  'assets/images/upload.png')),
                                          addVerticalSpace(1.5.h),
                                          Text(
                                            'Upload File',
                                            style: kBodyText16wNormal(black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  addVerticalSpace(5.h),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Visibility(
                visible: true,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomButton(
                      text: 'Send',
                      onTap: () {
                        if (tests["uploaded"].length == 0) {}
                      }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
