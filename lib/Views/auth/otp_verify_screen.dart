import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/Views/auth/succesfull_login_screen.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';

class OtpVeryfyScreen extends StatefulWidget {
  const OtpVeryfyScreen({super.key});

  @override
  State<OtpVeryfyScreen> createState() => _OtpVeryfyScreenState();
}

class _OtpVeryfyScreenState extends State<OtpVeryfyScreen> {
  final FocusNode _pinPutFocusNode = FocusNode();
  final TextEditingController _pinPutController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          addVerticalSpace(height(context) * 0.12),
          Text(
            'Enter OTP',
            style: const TextStyle(
                color: primary, fontSize: 36, fontWeight: FontWeight.w800),
          ),
          addVerticalSpace(height(context) * 0.02),
          SizedBox(
            width: width(context) * 0.75,
            child: Text(
              'Enter the verification code we just sent on your phone number.',
              textAlign: TextAlign.center,
              style: kBodyText16wBold(primary2),
            ),
          ),
          addVerticalSpace(height(context) * 0.04),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PinPut(
              animationDuration: const Duration(seconds: 0),
              eachFieldHeight: 8.h,
              eachFieldWidth: 20.w,
              fieldsCount: 4,
              autofocus: true,
              submittedFieldDecoration: k3DboxDecoration(20),
              selectedFieldDecoration: k3DboxDecoration(20),
              followingFieldDecoration: k3DboxDecoration(20),
              textStyle: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w400, color: primary),
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              pinAnimationType: PinAnimationType.fade,
              onTap: () {
                // setState(() {
                //   isTapped = true;
                // });
              },
            ),
          ),
          addVerticalSpace(height(context) * 0.03),
          TextButton(
              onPressed: () {},
              child: Text(
                'Resend OTP',
                style: kBodyText18wBold(primary),
              )),
          Spacer(),
          CustomButton(
              text: 'Verify',
              onTap: () {
                nextScreen(context, SuccessfullLogInscreen());
              }),
          addVerticalSpace(20)
        ],
      )),
    );
  }
}
