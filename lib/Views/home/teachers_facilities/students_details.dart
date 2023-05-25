import 'package:flutter/material.dart';
import 'package:offline_classes/Views/home/students_facilities/attendance_screen.dart';
import 'package:offline_classes/Views/home/students_facilities/my_profile_screen.dart';
import 'package:offline_classes/Views/home/students_facilities/notice_screen.dart';
import 'package:offline_classes/Views/home/students_facilities/progress_reports.dart';
import 'package:offline_classes/Views/home/teachers_facilities/gk_screen_for_teachers.dart';
import 'package:offline_classes/Views/home/teachers_facilities/test_series_teacher.dart';
import 'package:offline_classes/Views/home/teachers_facilities/view_student_profile.dart';
import 'package:offline_classes/global_data/student_global_data.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:sizer/sizer.dart';

import '../../../global_data/teacher_global_data.dart';
import '../../../utils/constants.dart';

class StudentsDetails extends StatelessWidget {
  const StudentsDetails({super.key, required this.student});

  final Map<String, dynamic> student;

  @override
  Widget build(BuildContext context) {
    print(student);
    return Scaffold(
      appBar: customAppbar2(context, 'Student Profile'),
      body: Column(
        children: [
          addVerticalSpace(2.h),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(12),
            // height: 12.h,
            width: 93.w,
            decoration: kGradientBoxDecoration(35, purpleGradident()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 11.h,
                  width: 25.w,
                  decoration: kGradientBoxDecoration(18, orangeGradient()),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Image.network(
                      "${GlobalTeacher.urlPrefix}${student["aadhar"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                addHorizontalySpace(5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student["name"],
                      style: kBodyText22bold(white),
                    ),
                    addVerticalSpace(2),
                    Text(
                      "+${student["phone"]}",
                      style: kBodyText12wNormal(white),
                    ),
                    addVerticalSpace(2),
                    Text(
                      student["subject"],
                      style: kBodyText12wNormal(white),
                    ),
                    addHorizontalySpace(2.w),
                    InkWell(
                      onTap: () {
                        nextScreen(
                          context,
                          ViewStudentProfile(studentlist: student),
                        );
                      },
                      child: Text(
                        'View Profile',
                        style: kBodyText10wBold(Colors.amber),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          addVerticalSpace(4.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8.h,
                width: 18.w,
                decoration: kGradientBoxDecoration(20, orangeGradient()),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/sp1.png'),
                ),
              ),
              InkWell(
                onTap: () {
                  nextScreen(context, AttendaceCalendar());
                },
                child: Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Student Attendance',
                          style: kBodyText16wBold(black),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          addVerticalSpace(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8.h,
                width: 18.w,
                decoration: kGradientBoxDecoration(20, orangeGradient()),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/pencil.png'),
                ),
              ),
              InkWell(
                onTap: () {
                  nextScreen(
                      context,
                      TestSeriesForTeacher(
                        title: 'Test Series',
                      ));
                },
                child: Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Test Series',
                          style: kBodyText16wBold(black),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          addVerticalSpace(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8.h,
                width: 18.w,
                decoration: kGradientBoxDecoration(20, orangeGradient()),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/set3.png'),
                ),
              ),
              InkWell(
                onTap: () {
                  nextScreen(context, ProgressReports());
                },
                child: Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Progress Report',
                          style: kBodyText16wBold(black),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          addVerticalSpace(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8.h,
                width: 18.w,
                decoration: kGradientBoxDecoration(20, orangeGradient()),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/set3.png'),
                ),
              ),
              InkWell(
                onTap: () {
                  nextScreen(
                      context,
                      TestSeriesForTeacher(
                        title: 'Students Doubts',
                      ));
                },
                child: Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Student Doubts',
                          style: kBodyText16wBold(black),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          addVerticalSpace(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8.h,
                width: 18.w,
                decoration: kGradientBoxDecoration(20, orangeGradient()),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/sf9.png'),
                ),
              ),
              InkWell(
                onTap: () {
                  nextScreen(
                      context,
                      AddGKContent(
                          student_id: student["id"], category: "foryou"));
                },
                child: Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'General Knowledge',
                          style: kBodyText16wBold(black),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          addVerticalSpace(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8.h,
                width: 18.w,
                decoration: kGradientBoxDecoration(20, orangeGradient()),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/sf10.png'),
                ),
              ),
              InkWell(
                onTap: () {
                  nextScreen(
                    context,
                    AddNoticeScreen(
                      type: "foryou",
                      student_id: student["id"],
                    ),
                  );
                },
                child: Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Notice',
                          style: kBodyText16wBold(black),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
