import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/Views/home/students_facilities/gk_screen.dart';
import 'package:offline_classes/Views/home/students_facilities/logout_screen.dart';
import 'package:offline_classes/Views/home/students_facilities/my_profile_screen.dart';
import 'package:offline_classes/Views/home/students_facilities/notice_screen.dart';
import 'package:offline_classes/Views/home/students_facilities/settings_screen.dart';
import 'package:offline_classes/Views/home/teachers_facilities/gk_screen_for_teachers.dart';
import 'package:offline_classes/Views/home/teachers_facilities/list_of_students.dart';
import 'package:offline_classes/Views/home/teachers_facilities/write_to_us_screen.dart';
import 'package:offline_classes/global_data/GlobalData.dart';
import 'package:sizer/sizer.dart';

import '../../../model/statics_list.dart';
import '../../../utils/constants.dart';

class TeacherFacilities extends StatelessWidget {
  const TeacherFacilities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        foregroundColor: black,
        leading: SizedBox(),
        title: Text(
          'Teacher Facilities',
          style: kBodyText20wBold(primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                nextScreen(
                    context,
                    MyProfileScreen(
                        image: 'assets/images/dummy2.png',
                        username: 'Anup Sharma'));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.only(
                    left: 2.w, right: 5.w, top: 2.h, bottom: 2.h),
                // height: 12.h,
                width: 93.w,
                decoration: kGradientBoxDecoration(35, purpleGradident()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 12.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Anup Sharma',
                            style: kBodyText22bold(white),
                          ),
                          Text(
                            'Mumbai, Maharashtra',
                            style: kBodyText12wNormal(white),
                          ),
                          Text(
                            GlobalData.phoneNumber,
                            style: kBodyText12wNormal(white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 12.h,
                      width: 25.w,
                      decoration: kGradientBoxDecoration(18, orangeGradient()),
                      child: Image.asset('assets/images/dummy2.png'),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(1.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: teacherFacilityList.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      childAspectRatio: 0.83),
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {
                        if (i == 0) {
                          nextScreen(
                              context,
                              MyProfileScreen(
                                  image: 'assets/images/dummy2.png',
                                  username: 'Anup Sharma'));
                        } else if (i == 1) {
                          nextScreen(
                              context,
                              NoticeScreen(
                                isVisible: true,
                              ));
                        } else if (i == 2) {
                          nextScreen(context, GKScreenForTeacher());
                        } else if (i == 3) {
                          nextScreen(context, WriteToUsScreen());
                        } else if (i == 4) {
                          nextScreen(
                              context,
                              SettingsScreen(
                                isVisible: false,
                              ));
                        } else if (i == 5) {
                          nextScreen(context, LogoutScreen());
                        } else if (i == 6) {
                          nextScreen(context, ListOfStudentsScreen());
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        // padding: EdgeInsets.all(10),
                        height: 17.h,
                        width: 33.w,
                        decoration: k3DboxDecorationWithColor(
                          35,
                          teacherFacilityList[i]['color'],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                height: 8.4.h,
                                child:
                                    Image.asset(teacherFacilityList[i]['img'])),
                            Text(
                              teacherFacilityList[i]['title'],
                              style: kBodyText14w500withoutSizer(black),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
