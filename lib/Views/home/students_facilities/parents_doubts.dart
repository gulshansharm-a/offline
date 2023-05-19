import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:offline_classes/widget/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/my_appbar.dart';

class ParentsDoubts extends StatelessWidget {
  const ParentsDoubts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Parents Doubts'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            addVerticalSpace(2.h),
            CustomTextfield(hintext: 'Title'),
            addVerticalSpace(4.h),
            CustomTextfieldMaxLine(hintext: 'Description'),
            addVerticalSpace(6.h),
            SizedBox(
              width: 50.w,
              child: CustomButton(text: 'Submit', onTap: () {}),
            ),
            addVerticalSpace(6.h),
            Text(
              'OR',
              style: kBodyText24wBold(black),
            ),
            addVerticalSpace(6.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 16.h,
                    width: 42.w,
                    decoration: kGradientBoxDecoration(30, purpleGradident()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 7.h,
                            child: Image.asset('assets/images/camera.png')),
                        Text(
                          'Attache File',
                          style: kBodyText16wBold(white),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 16.h,
                    width: 42.w,
                    decoration: kGradientBoxDecoration(30, purpleGradident()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 7.h,
                            child: Image.asset('assets/images/phone1.png')),
                        Text(
                          'Call',
                          style: kBodyText16wBold(white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
