import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:offline_classes/widget/custom_textfield.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  ContactUs({super.key});

  TextEditingController tfname = TextEditingController();
  TextEditingController tfmail = TextEditingController();
  TextEditingController tfmessage = TextEditingController();

  void sendEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path:
          '12a.manvendrasingh@gmail.com', // Replace with the recipient email address
      query:
          'subject=From ${tfmail.text}&body=${tfmessage.text}?', // Replace with your email subject and body
    );

    final String url = params.toString();

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl((Uri.parse(url)));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          Center(
            child: CustomTextfield(
              hintext: 'Name',
              controller: tfname,
            ),
          ),
          addVerticalSpace(2.h),
          Center(
            child: CustomTextfield(
              hintext: 'Email ID',
              controller: tfmail,
            ),
          ),
          addVerticalSpace(2.h),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomTextfieldMaxLine(
                hintext: 'Message',
                controller: tfmessage,
              ),
            ),
          ),
          Spacer(),
          Center(
              child: CustomButton(
            text: 'Submit',
            onTap: sendEmail,
          )),
          addVerticalSpace(4.h),
        ],
      ),
    );
  }
}
