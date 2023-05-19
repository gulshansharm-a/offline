import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/Views/home/home_screen.dart';
import 'package:offline_classes/model/statics_list.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:offline_classes/widget/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../../widget/my_bottom_navbar.dart';

class TeacherEnquiryForm extends StatefulWidget {
  const TeacherEnquiryForm({super.key});

  @override
  State<TeacherEnquiryForm> createState() => _TeacherEnquiryFormState();
}

class _TeacherEnquiryFormState extends State<TeacherEnquiryForm> {
  List genderList = ['Male', 'Female'];
  int? selectedIndex;
  String qaulificationValue = 'Qualification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                height: 30.h,
                width: width(context) * 0.95,
                decoration: kGradientBoxDecoration(42, purpleGradident()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 20.h,
                        child: Image.asset('assets/images/teacher1.png')),
                    // addVerticalSpace(4),
                    Text(
                      'Teacher Enquiry',
                      style: kBodyText30wBold(white),
                    )
                  ],
                ),
              ),
              addVerticalSpace(30),
              CustomTextfield(
                hintext: 'Teacher Name',
              ),
              addVerticalSpace(10),
              SizedBox(
                height: 60,
                child: ListView.builder(
                    itemCount: genderList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) {
                      return Row(
                        children: [
                          addHorizontalySpace(10),
                          InkWell(
                            onTap: () {
                              selectedIndex = i;
                              setState(() {});
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: selectedIndex == i
                                  ? kGradientBoxDecoration2(10, greenGradient())
                                  : k3DboxDecoration(10),
                              child: selectedIndex == i
                                  ? const Icon(
                                      Icons.check,
                                      color: white,
                                      size: 40,
                                    )
                                  : SizedBox(),
                            ),
                          ),
                          addHorizontalySpace(10),
                          Text(
                            genderList[i],
                            style: kBodyText16wNormal(textColor),
                          ),
                          addHorizontalySpace(15)
                        ],
                      );
                    }),
              ),
              addVerticalSpace(10),
              Container(
                height: 8.5.h,
                width: 95.w,
                padding: EdgeInsets.only(left: 9.w, top: 7, right: 9.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    const BoxShadow(
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
                child: Center(
                  child: DropdownButton<String>(
                    value: qaulificationValue,
                    hint: Text('Select', style: kBodyText14w500(textColor)),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: textColor,
                      size: 30,
                    ),
                    // elevation: 10,
                    style: kBodyText14w500(Color(0xffA4A4A4)),

                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    isExpanded: true,
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        qaulificationValue = newValue!;
                      });
                    },
                    items: [
                      'Qualification',
                      'Non-Matric',
                      'Matric',
                      'Intermidiate',
                      'Graduated',
                      'Under-graduated',
                      'Post-graduated'
                    ].map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: kBodyText14w500(textColor),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              addVerticalSpace(15),
              CustomTextfield(hintext: 'City/Town'),
              addVerticalSpace(15),
              CustomTextfield(
                hintext: 'Pincode',
                keyBoardType: TextInputType.number,
              ),
              addVerticalSpace(height(context) * 0.04),
              CustomButton(
                  text: 'Enquire',
                  onTap: () {
                    nextScreen(
                        context,
                        HomeScreen(
                          whoAreYou: 'Teacher',
                          serviceList: teacherServiceList,
                          sliderList: const [
                            'Annual Gift Hamper',
                            '100% Trusted & Satisfied'
                          ],
                          heading:
                              'Trusir is a registered and trusted Indian company that offers Home to Home tuition service. We have a clear vision of helping male and female teaching service.',
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
