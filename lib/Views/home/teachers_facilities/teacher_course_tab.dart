import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../global_data/GlobalData.dart';
import '../../../global_data/student_global_data.dart';
import '../../../utils/constants.dart';
import '../../../widget/custom_button.dart';

class TeachersCourseTab extends StatefulWidget {
  const TeachersCourseTab({super.key});

  @override
  State<TeachersCourseTab> createState() => _TeachersCourseTabState();
}

class _TeachersCourseTabState extends State<TeachersCourseTab> {
  Future<void> getCourses() async {
    final http.Response response = await http.get(Uri.parse(
        "https://trusher.shellcode.co.in/api/courses?authKey=${GlobalData.auth1}&user_id=${GlobalStudent.id}&class=${GlobalStudent.specificProfile["data"][0]["class"]}&medium=${GlobalStudent.specificProfile["data"][0]["medium"]}"));
    courses = json.decode(response.body);
    if (response.statusCode == 200) {
      print(courses);
    } else {
      print("Unsuccessful");
    }
  }

  Map<String, dynamic> courses = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        foregroundColor: black,
        elevation: 0,
        leadingWidth: width(context) * 0.4,
        leading: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            '  Courses',
            style: kBodyText20wBold(primary),
          ),
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (false) {
            return const Center(
                child: CircularProgressIndicator(color: primary2));
          } else {
            return Column(
              children: [
                Center(
                  child: Text(
                    'Courses List',
                    style: kBodyText20wBold(primary),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (ctx, i) {
                        return Container(
                          margin: EdgeInsets.all(2.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 1.7.h),
                          // height: 21.h,
                          width: 95.w,
                          decoration:
                              kGradientBoxDecoration(42, purpleGradident()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Divya Shah',
                                style: kBodyText24wBold(white),
                              ),
                              Text(
                                'Course Started On : 20/2/2023',
                                style: kBodyText14w500(white),
                              ),
                              Text(
                                'Subject : English',
                                style: kBodyText14w500(white),
                              ),
                              Text(
                                'Pune,Maharashtra',
                                style: kBodyText14w500(white),
                              ),
                              addVerticalSpace(5),
                              Container(
                                  decoration: kGradientBoxDecoration(
                                      30, greenGradient()),
                                  width: 32.w,
                                  height: 4.5.h,
                                  child: Center(
                                    child: Text(
                                      i % 2 == 0 ? 'Demo Course' : 'Full Plan',
                                      style: kBodyText12wBold(white),
                                    ),
                                  )),
                            ],
                          ),
                        );
                      }),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
