import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/Views/auth/otp_verify_screen.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List pageviewList = [
    {
      'title': 'Home Tuitions',
      'subtitle': 'Get the tuition from the best teachers at your home '
    },
    {
      'title': 'Special Education',
      'subtitle': 'Education for your child at home with personal attention'
    },
    {
      'title': '100%  Satisfaction',
      'subtitle': '100% student satisfaction and a great learning experience'
    },
    {'title': 'Trusted Teachers', 'subtitle': 'Trusted teachers by Trusir'},
    {
      'title': 'Monthly Test Series',
      'subtitle': 'Test series every month facility to test your kids'
    },
  ];
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  double? size;
  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    size = width(context) * 0.93;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(23),
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: () {
                    log(size.toString());
                  },
                  child: Text(
                    'Language',
                    style: kBodyText18wNormal(black),
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 22,
                ),
              ],
            ),
            addVerticalSpace(40),
            SizedBox(
              height: 57.h,
              // width: width(context) * 0.93,
              child: PageView.builder(
                  itemCount: pageviewList.length,
                  controller: controller,
                  itemBuilder: (ctx, i) {
                    return Column(
                      children: [
                        Text(
                          pageviewList[i]['title'],
                          style: const TextStyle(
                              color: primary,
                              fontSize: 36,
                              fontWeight: FontWeight.w800),
                        ),
                        addVerticalSpace(1.5.h),
                        SizedBox(
                          width: width(context) * 0.7,
                          child: Text(
                            pageviewList[i]['subtitle'],
                            textAlign: TextAlign.center,
                            style: kBodyText16wBold(primary2),
                          ),
                        ),
                        addVerticalSpace(10),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Image.asset('assets/images/loginimg.png'),
                        ))
                      ],
                    );
                  }),
            ),
            addVerticalSpace(5),
            SmoothPageIndicator(
              count: pageviewList.length,
              controller: controller,
              effect: ExpandingDotsEffect(
                  spacing: width(context) * 0.015,
                  dotWidth: width(context) * 0.02,
                  dotHeight: width(context) * 0.025,
                  dotColor: const Color.fromRGBO(219, 207, 240, 1),
                  activeDotColor: primary), // WormEffect
            ),
            addVerticalSpace(30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              height: height(context) * 0.065,
              width: width(context) * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: textColor,
                    offset: Offset(0, 3),
                  ),
                  BoxShadow(
                    color: white.withOpacity(0.95),
                    // spreadRadius: -2.0,
                    blurRadius: 7.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  addVerticalSpace(5),
                  Center(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[0-9]"),
                        )
                      ],
                      decoration: InputDecoration(
                          prefixIcon: Image.asset('assets/images/ind2.png'),
                          border: InputBorder.none,
                          hintText: '+91 |  Mobile Number'),
                    ),
                  ),
                ],
              ),
            ),
            addVerticalSpace(height(context) * 0.055),
            CustomButton(
                text: 'Send OTP',
                onTap: () {
                  nextScreen(context, OtpVeryfyScreen());
                })
          ],
        ),
      )),
    );
  }
}
