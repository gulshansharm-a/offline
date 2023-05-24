import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offline_classes/Views/home/students_facilities/teachers_list.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:offline_classes/widget/custom_textfield.dart';
import 'package:offline_classes/widget/image_opener.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/my_appbar.dart';

class ParentsDoubts extends StatefulWidget {
  const ParentsDoubts({super.key});

  @override
  State<ParentsDoubts> createState() => _ParentsDoubtsState();
}

class _ParentsDoubtsState extends State<ParentsDoubts> {
  ImagePicker _picker = ImagePicker();

  bool showSpinner = false;

  File? image;

  TextEditingController tfTitle = TextEditingController();
  TextEditingController tfDescription = TextEditingController();

  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar("Error", "Call Could not be sent");
    }
  }

  submit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, 'Parents Doubts'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              addVerticalSpace(2.h),
              CustomTextfield(hintext: 'Title'),
              addVerticalSpace(4.h),
              CustomTextfieldMaxLine(hintext: 'Description'),
              addVerticalSpace(6.h),
              SizedBox(
                width: 50.w,
                child: CustomButton(
                  text: 'Submit',
                  onTap: () {
                    submit();
                  },
                ),
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
                    onTap: () async {
                      final pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 80,
                      );

                      if (pickedFile != null) {
                        image = File(pickedFile.path);
                        Get.snackbar("Success", "Image Selected Successfully");
                        setState(() {
                          showSpinner = false;
                          nextScreen(
                            context,
                            ImageOpener(
                              imageFile: image,
                              showOnly: false,
                              baseurl: "/jns",
                            ),
                          );
                        });
                      } else {
                        Get.snackbar("Error", "Image Not Uploaded");
                        print("No image selected");
                      }
                    },
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
                    onTap: () {
                      //_launchPhone('8577098983');
                      nextScreen(context, TeachersListScreen());
                    },
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
      ),
    );
  }
}
