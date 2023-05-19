import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/Views/home/students_facilities/select_teacher_for_call.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:sizer/sizer.dart';

class StudentsDoubts extends StatelessWidget {
  const StudentsDoubts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Student Doubts'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 25.h,
                width: 90.w,
                decoration: kGradientBoxDecoration(60, purpleGradident()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 12.h,
                        child: Image.asset('assets/images/camera.png')),
                    Text(
                      'Upload From Camera',
                      style: kBodyText20wBold(white),
                    )
                  ],
                ),
              ),
            ),
          ),
          addVerticalSpace(4.h),
          Center(
            child: InkWell(
              onTap: () {
                nextScreen(context, SelectTeacherForCall());
              },
              child: Container(
                height: 25.h,
                width: 90.w,
                decoration: kGradientBoxDecoration(60, purpleGradident()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 12.h,
                        child: Image.asset('assets/images/phone1.png')),
                    Text(
                      'Call Teacher',
                      style: kBodyText20wBold(white),
                    )
                  ],
                ),
              ),
            ),
          ),
          addVerticalSpace(5.h)
        ],
      ),
    );
  }
}
