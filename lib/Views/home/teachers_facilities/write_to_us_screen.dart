import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants.dart';
import '../../../utils/my_appbar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';

class WriteToUsScreen extends StatelessWidget {
  const WriteToUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Write To Us '),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            addVerticalSpace(2.h),
            CustomTextfield(hintext: 'Title'),
            addVerticalSpace(3.h),
            CustomTextfieldMaxLine(hintext: 'Description'),
            Spacer(),
            CustomButton(text: 'Submit', onTap: () {}),
            addVerticalSpace(2.h)
          ],
        ),
      ),
    );
  }
}
