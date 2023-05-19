import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants.dart';
import '../../../widget/custom_button.dart';

class TeachersCourseTab extends StatelessWidget {
  const TeachersCourseTab({super.key});

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
      body: Column(
        children: [
          Center(
            child: Text(
              'Courses List',
              style: kBodyText20wBold(primary),
            ),
          ),
          Expanded(
            child: ListView.builder(itemBuilder: (ctx, i) {
              return Container(
                margin: EdgeInsets.all(2.h),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.7.h),
                // height: 21.h,
                width: 95.w,
                decoration: kGradientBoxDecoration(42, purpleGradident()),
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
                        decoration: kGradientBoxDecoration(30, greenGradient()),
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
      ),
    );
  }
}
