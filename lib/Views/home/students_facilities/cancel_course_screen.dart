import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

import '../../../global_data/GlobalData.dart';
import '../../../global_data/student_global_data.dart';
import '../../../utils/constants.dart';
import '../../../widget/custom_button.dart';

class CancelCourseScreen extends StatefulWidget {
  const CancelCourseScreen({Key? key}) : super(key: key);

  @override
  _CancelCourseScreenState createState() => _CancelCourseScreenState();
}

class _CancelCourseScreenState extends State<CancelCourseScreen> {
  bool showSpinner = false;

  Future<void> delete() async {}

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          foregroundColor: black,
          elevation: 0,
          leadingWidth: width(context) * 0.4,
          leading: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              'Cancel Courses',
              style: kBodyText20wBold(primary),
            ),
          ),
        ),
        body: FutureBuilder(
            future: delete(),
            builder: (context, snapshot) {
              if (GlobalStudent.courses.isEmpty) {
                return const Center(
                  child: Text("No Courses to Delete"),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      addVerticalSpace(10),
                      Center(
                        child: Text(
                          'Courses Enrolled',
                          style: kBodyText18wBold(primary),
                        ),
                      ),
                      addVerticalSpace(3.h),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: GlobalStudent.courses["mycourse"].length,
                        itemBuilder: (ctx, i) {
                          GlobalStudent.courses["mycourse"][i]["id"];
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 1.5.h),
                            // height: 11.h,
                            width: 93.w,
                            decoration:
                                kGradientBoxDecoration(35, purpleGradident()),
                            // decoration: kFillBoxDecoration(0, Color(0xff48116a), 35),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      GlobalStudent.courses["mycourse"][i]
                                          ["course_name"],
                                      style: kBodyText24wBold(white),
                                    ),
                                    Spacer(),
                                    addHorizontalySpace(5.w),
                                    InkWell(
                                      onTap: () {
                                        confirmationPopup(context);
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 10,
                                        child: Icon(
                                          Icons.close,
                                          size: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  'Course started on: ${GlobalStudent.courses["mycourse"][i]["dt"].toString().substring(0, GlobalStudent.courses["mycourse"][i]["dt"].indexOf(" "))}',
                                  style: kBodyText15wNormal(white),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }

  Future<dynamic> confirmationPopup(BuildContext context) {
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
              height: height * 0.3,
              // decoration: kFillBoxDecoration(0, white, 40),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Are you sure you want to cancel this Course?',
                    style: kBodyText18wBold(black),
                    textAlign: TextAlign.center,
                  ),
                  addVerticalSpace(2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          goBack(context);
                        },
                        child: Container(
                          height: 5.h,
                          width: 20.w,
                          decoration: kOutlineBoxDecoration(2, green, 18),
                          child: Center(
                            child: Text(
                              'No',
                              style: kBodyText16wBold(green),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                        width: 20.w,
                        child: CustomButton(
                          text: 'Yes',
                          onTap: () {
                            GlobalStudent.purchasedCourses.remove(
                                GlobalStudent.courses["mycourse"][0]["id"]);
                            goBack(context);
                            deleteCourse();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void deleteCourse() async {
    setState(() {
      showSpinner = true;
    });
    final http.Response response = await http.get(Uri.parse(
        "https://trusher.shellcode.co.in/api/coursesDelete?authKey=${GlobalData.auth1}&user_id=${GlobalStudent.id}&course_id=${GlobalStudent.courses["data"][0]["id"]}"));

    Map<String, dynamic> map = json.decode(response.body);
    if (response.statusCode == 200) {
      print(map["Message"]);
      if (map["Message"] == "course deletion failed ,try again!") {
        Get.snackbar("Failure", "Course not deleted or does not exist.");
      } else {
        Get.snackbar("Success", "Course Deleted");
      }
    } else {
      Get.snackbar("Failure", "Course not deleted or does not exist.");
    }
    setState(() {
      showSpinner = false;
    });
  }
}