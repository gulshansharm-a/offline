import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, ''),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(12.h),
            Center(
              child: Container(
                height: 17.h,
                width: 39.w,
                decoration: kGradientBoxDecoration(40, orangeGradient()),
                child: Image.asset('assets/images/dummy1.png'),
              ),
            ),
            addVerticalSpace(6.h),
            Text(
              'Are you sure you want to Logout?',
              style: kBodyText20wBold(black),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            CustomButtonOutline(
                textWidget: Text(
                  'Cancel',
                  style: kBodyText18wBold(green),
                ),
                ontap: () {
                  goBack(context);
                },
                width: 90.w,
                height: 6.5.h),
            addVerticalSpace(2.h),
            CustomButton(text: 'Logout', onTap: () {}),
            addVerticalSpace(1.h)
          ],
        ),
      ),
    );
  }
}
