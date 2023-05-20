import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/Views/enquiry_registrations/student_enquiry_form.dart';
import 'package:offline_classes/Views/enquiry_registrations/teacher_enquiry_form.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:sizer/sizer.dart';

class EnquirySelectStudentOrTeachers extends StatelessWidget {
  const EnquirySelectStudentOrTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(height(context) * 0.07),
            Center(
              child: InkWell(
                onTap: () {
                  nextScreen(context, StudentEnquiryForm());
                },
                child: Container(
                  height: 25.h,
                  // width: 95.w,
                  margin: EdgeInsets.all(14),
                  decoration: kGradientBoxDecoration(42, purpleGradident()),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          // height: height(context) * 0.22,
                          width: 40.w,
                          child: Image.asset('assets/images/student1.png')),
                      // addHorizontalySpace(10),
                      Text(
                        'Student \nEnquiry',
                        style: kBodyText32wBold(white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            addVerticalSpace(2.h),
            Center(
              child: InkWell(
                onTap: () {
                  nextScreen(context, TeacherEnquiryForm());
                },
                child: Container(
                  height: 25.h,
                  // width: width(context) * 0.95,
                  margin: EdgeInsets.all(14),
                  decoration: kGradientBoxDecoration(42, purpleGradident()),
                  // decoration: kFillBoxDecoration(0, Color(0xff48116a), 42),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          // height: height(context) * 0.18,
                          width: 40.w,
                          child: Image.asset('assets/images/teacher1.png')),
                      Text(
                        'Teacher \nEnquiry',
                        style: kBodyText32wBold(white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            addVerticalSpace(3.h),
            Text(
              'Or Enquire On',
              style: kBodyText18wBold(primary),
            ),
            addVerticalSpace(height(context) * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                        height: height(context) * 0.09,
                        child: Image.asset('assets/images/wp.png')),
                    addVerticalSpace(10),
                    Text(
                      'Whatsapp',
                      style: kBodyText16wNormal(primary),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: height(context) * 0.1,
                        child: Image.asset('assets/images/phone.png')),
                    addVerticalSpace(10),
                    Text(
                      'Call',
                      style: kBodyText16wNormal(primary),
                    )
                  ],
                ),
                // Image.asset('assets/images/phone.png'),
              ],
            )
          ],
        ),
      )),
    );
  }
}
