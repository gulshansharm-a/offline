import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';
import '../../../widget/custom_back_button.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({super.key});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar("Error", "Cannot make a call.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 42.h,
              padding: EdgeInsets.all(2.h),
              width: width(context),
              decoration: BoxDecoration(
                  gradient: purpleGradident(),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100))),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomBackButton(),
                        addHorizontalySpace(10),
                        Text(
                          "Teacher Profile",
                          textAlign: TextAlign.center,
                          style: kBodyText20wBold(white),
                        ),
                      ],
                    ),
                    addVerticalSpace(10),
                    Container(
                      height: 17.h,
                      width: 39.w,
                      decoration: kGradientBoxDecoration(40, orangeGradient()),
                      child: Image.asset('assets/images/dummy2.png'),
                    ),
                    addVerticalSpace(0.5.h),
                    Text(
                      'Anup Sharma',
                      style: kBodyText27wBold(white),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(7.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(1.5.h),
                  height: 8.h,
                  width: 18.w,
                  decoration: kGradientBoxDecoration(20, orangeGradient()),
                  child: Image.asset('assets/images/tp1.png'),
                ),
                Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addHorizontalySpace(width(context) * 0.06),
                      Text(
                        '36, Male',
                        style: kBodyText16wBold(black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            addVerticalSpace(height(context) * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(1.5.h),
                  height: 8.h,
                  width: 18.w,
                  decoration: kGradientBoxDecoration(20, orangeGradient()),
                  child: Image.asset('assets/images/tp2.png'),
                ),
                Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addHorizontalySpace(width(context) * 0.06),
                      Text(
                        'Mumbai,Maharahstra',
                        style: kBodyText16wBold(black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            addVerticalSpace(height(context) * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(1.5.h),
                  height: 8.h,
                  width: 18.w,
                  decoration: kGradientBoxDecoration(20, orangeGradient()),
                  child: Image.asset('assets/images/tp3.png'),
                ),
                Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addHorizontalySpace(width(context) * 0.06),
                      Text(
                        'B.Ed',
                        style: kBodyText16wBold(black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            addVerticalSpace(height(context) * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 8.h,
                  width: 18.w,
                  padding: EdgeInsets.all(1.5.h),
                  decoration: kGradientBoxDecoration(20, orangeGradient()),
                  child: Image.asset(
                    'assets/images/tp4.png',
                  ),
                ),
                Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addHorizontalySpace(width(context) * 0.06),
                      SizedBox(
                        width: 69.w,
                        child: Text(
                          '5 years ',
                          style: kBodyText16wBold(black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            addVerticalSpace(height(context) * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 8.h,
                  padding: EdgeInsets.all(1.h),
                  width: 18.w,
                  decoration: kGradientBoxDecoration(20, orangeGradient()),
                  child: Image.asset(
                    'assets/images/pencil.png',
                  ),
                ),
                Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addHorizontalySpace(width(context) * 0.06),
                      SizedBox(
                        width: 69.w,
                        child: Text(
                          'Maths and Science',
                          style: kBodyText16wBold(black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            addVerticalSpace(height(context) * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _launchPhone('8577098983');
                  },
                  child: Container(
                    height: 8.h,
                    padding: EdgeInsets.all(1.h),
                    width: 18.w,
                    decoration: kGradientBoxDecoration(20, orangeGradient()),
                    child: Image.asset(
                      'assets/images/phone.png',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchPhone('8577098983');
                  },
                  child: Container(
                    height: 8.h,
                    width: 75.w,
                    decoration: kFillBoxDecoration(0, skinColor, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addHorizontalySpace(width(context) * 0.06),
                        SizedBox(
                          width: 69.w,
                          child: Text(
                            '9130168812',
                            style: kBodyText16wBold(black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpace(height(context) * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(1.5.h),
                  height: 8.h,
                  width: 18.w,
                  decoration: kGradientBoxDecoration(20, orangeGradient()),
                  child: Image.asset(
                    'assets/images/tp6.png',
                  ),
                ),
                Container(
                  height: 8.h,
                  width: 75.w,
                  decoration: kFillBoxDecoration(0, skinColor, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addHorizontalySpace(width(context) * 0.06),
                      Text(
                        'English Medium',
                        style: kBodyText16wBold(black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            addVerticalSpace(2.h)
          ],
        ),
      ),
    );
  }
}
