import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:offline_classes/widget/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Contact Us'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Hello',
              style: kBodyText40wBold(primary),
            ),
          ),
          addVerticalSpace(2.h),
          Center(child: CustomTextfield(hintext: 'Name')),
          addVerticalSpace(2.h),
          Center(child: CustomTextfield(hintext: 'Email ID')),
          addVerticalSpace(2.h),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomTextfieldMaxLine(hintext: 'Message'),
          )),
          Spacer(),
          Center(child: CustomButton(text: 'Submit', onTap: () {})),
          addVerticalSpace(4.h),
        ],
      ),
    );
  }
}
