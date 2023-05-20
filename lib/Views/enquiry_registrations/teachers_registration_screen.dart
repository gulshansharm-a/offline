import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:offline_classes/Views/enquiry_registrations/payment_method.dart';
import 'package:offline_classes/Views/enquiry_registrations/registration_successfull.dart';
import 'package:offline_classes/razorpay_payments/razorpay_screen.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../../model/statics_list.dart';
import '../../utils/constants.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_item_seleted_field.dart';

class TeacherRegistration extends StatefulWidget {
  const TeacherRegistration({super.key});

  @override
  State<TeacherRegistration> createState() => _TeacherRegistrationState();
}

class _TeacherRegistrationState extends State<TeacherRegistration> {
  final TextEditingController datofBirthControler = TextEditingController();
  String drodownValue = 'Gender';
  String classValue = 'Class';
  String stateValue = 'State';
  String cityValue = 'City/Town';
  String qaulificationValue = 'Qualification';
  String expValue = 'Experience';
  List genderList = ['Gender', 'Male', 'Female', 'Others'];
  bool isSelect = false;
  bool isMedium = false;
  bool isSubject = false;
  bool isPrefferedClass = false;
  bool isAgree = false;
  int? selectStudent;
  int? selectMedium;
  int? selectedSubject;
  int? selectedClass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, ''),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 32.h,
                width: 95.w,
                decoration: kGradientBoxDecoration(42, purpleGradident()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 22.h,
                        child: Image.asset('assets/images/teacher2.png')),
                    Text(
                      'Teacher Registration',
                      style: kBodyText25Bold(white),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(20),
              CustomTextfield(hintext: 'Teacher Name'),
              addVerticalSpace(15),
              CustomTextfield(hintext: "Father's Name"),
              addVerticalSpace(15),
              CustomTextfield(hintext: "Mother's Name"),
              addVerticalSpace(15),
              Row(
                children: [
                  Container(
                    height: 8.5.h,
                    width: 45.w,
                    padding: EdgeInsets.symmetric(
                      horizontal: 9.w,
                    ),
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
                        value: drodownValue,
                        hint: const Text(
                          'Select',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffB1B1B3),
                              fontWeight: FontWeight.w400),
                        ),
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
                            drodownValue = newValue!;
                          });
                        },
                        items:
                            genderList.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: kBodyText14w500(Color(0xffA4A4A4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 8.5.h,
                    width: 46.w,
                    child: CustomTextfield(
                      controller: datofBirthControler,
                      onTap: () {
                        pickDate();
                      },
                      hintext: 'DOB',
                      sufixIcon: Icons.calendar_month,
                    ),
                  )
                ],
              ),
              addVerticalSpace(15),
              CustomTextfield(
                hintext: "Phone Number",
                keyBoardType: TextInputType.number,
              ),
              addVerticalSpace(15),
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
                    hint: const Text(
                      'Select',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffB1B1B3),
                          fontWeight: FontWeight.w500),
                    ),
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
                          style: kBodyText14w500(Color(0xffA4A4A4)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              addVerticalSpace(15),
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
                    value: expValue,
                    hint: Text(
                      'Select',
                      style: kBodyText14w500(Color(0xffA4A4A4)),
                    ),
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
                        expValue = newValue!;
                      });
                    },
                    items: [
                      'Experience',
                      '1 Year',
                      '2 Year',
                      '3 Year',
                      '4 Year',
                      '5 Year',
                    ].map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: kBodyText14w500(Color(0xffA4A4A4)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              addVerticalSpace(15),
              CustomItemSelectedField(
                onTap: () {
                  isSubject = !isSubject;
                  setState(() {});
                },
                title: 'Preferred Class',
                isChanged: isSubject,
              ),
              if (isSubject)
                Column(
                  children: [
                    addVerticalSpace(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: SizedBox(
                        // height: height(context) * 0.2,
                        width: width(context) * 0.99,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.8,
                                    crossAxisSpacing: 8),
                            itemCount: classList.length,

                            // scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
                              return Row(
                                children: [
                                  // addHorizontalySpace(10),
                                  InkWell(
                                    onTap: () {
                                      classList[i]['select'] =
                                          !classList[i]['select'];
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: classList[i]['select'] == true
                                          ? kGradientBoxDecoration2(
                                              10, greenGradient())
                                          : k3DboxDecoration(10),
                                      child: classList[i]['select'] == true
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
                                    classList[i]['title'],
                                    style: kBodyText14wBold(textColor),
                                  ),
                                  // addHorizontalySpace(15)
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              addVerticalSpace(10),
              CustomItemSelectedField(
                onTap: () {
                  isMedium = !isMedium;
                  setState(() {});
                },
                title: 'Medium',
                isChanged: isMedium,
              ),
              if (isMedium)
                Column(
                  children: [
                    addVerticalSpace(10),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                          itemCount: mediumList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return Row(
                              children: [
                                addHorizontalySpace(10),
                                InkWell(
                                  onTap: () {
                                    selectMedium = i;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: selectMedium == i
                                        ? kGradientBoxDecoration2(
                                            10, greenGradient())
                                        : k3DboxDecoration(10),
                                    child: selectMedium == i
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
                                  mediumList[i],
                                  style: kBodyText16wNormal(textColor),
                                ),
                                addHorizontalySpace(15)
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              addVerticalSpace(10),
              CustomItemSelectedField(
                onTap: () {
                  isPrefferedClass = !isPrefferedClass;
                  setState(() {});
                },
                title: 'Subject',
                isChanged: isPrefferedClass,
              ),
              if (isPrefferedClass)
                Column(
                  children: [
                    addVerticalSpace(10),
                    SizedBox(
                      // height: height(context) * 0.2,
                      width: width(context) * 0.99,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.8,
                                  crossAxisSpacing: 8),
                          itemCount: subjectList2.length,

                          // scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return Row(
                              children: [
                                // addHorizontalySpace(10),
                                InkWell(
                                  onTap: () {
                                    selectedSubject = i;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: selectedSubject == i
                                        ? kGradientBoxDecoration2(
                                            10, greenGradient())
                                        : k3DboxDecoration(10),
                                    child: selectedSubject == i
                                        ? const Icon(
                                            Icons.check,
                                            color: white,
                                            size: 40,
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                                addHorizontalySpace(6),
                                SizedBox(
                                  width: width(context) * 0.15,
                                  child: Text(
                                    subjectList2[i],
                                    style: kBodyText12wBold(textColor),
                                  ),
                                ),
                                // addHorizontalySpace(15)
                              ],
                            );
                          }),
                    ),
                  ],
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
                    value: stateValue,
                    hint: Text(
                      'Select',
                      style: kBodyText14w500(Color(0xffA4A4A4)),
                    ),
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
                        stateValue = newValue!;
                      });
                    },
                    items: ['State', 'Bihar']
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: kBodyText14w500(Color(0xffA4A4A4)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              addVerticalSpace(15),
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
                    value: cityValue,
                    hint: Text(
                      'Select',
                      style: kBodyText14w500(Color(0xffA4A4A4)),
                    ),
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
                        cityValue = newValue!;
                      });
                    },
                    items: ['City/Town', 'Motihari']
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: kBodyText14w500(Color(0xffA4A4A4)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              addVerticalSpace(15),
              CustomTextfield(hintext: "Mohalla/Area"),
              addVerticalSpace(15),
              CustomTextfield(
                hintext: "Pincode",
                keyBoardType: TextInputType.number,
              ),
              addVerticalSpace(15),
              CustomTextfieldMaxLine(hintext: 'Current Full Address'),
              addVerticalSpace(15),
              CustomTextfieldMaxLine(hintext: 'Permanent Full Address'),
              addVerticalSpace(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Photo',
                    style: kBodyText16wBold(black),
                  ),
                  Container(
                    height: 7.h,
                    width: 55.w,
                    decoration: k3DboxDecoration(14),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.upload,
                            size: 30,
                            color: Color(0xffA4A4A4),
                          ),
                          Text(
                            'Upload Image',
                            style: kBodyText14w500(Color(0xffA4A4A4)),
                          )
                        ]),
                  )
                ],
              ),
              addVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Aadhar Card',
                    style: kBodyText16wBold(black),
                  ),
                  Container(
                    height: 7.h,
                    width: 55.w,
                    decoration: k3DboxDecoration(14),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.upload,
                            size: 30,
                            color: Color(0xffA4A4A4),
                          ),
                          Text(
                            'Upload Image',
                            style: kBodyText14w500(Color(0xffA4A4A4)),
                          )
                        ]),
                  )
                ],
              ),
              addVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Signatures',
                    style: kBodyText16wBold(black),
                  ),
                  Container(
                    height: 7.h,
                    width: 55.w,
                    decoration: k3DboxDecoration(14),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.upload,
                            size: 30,
                            color: Color(0xffA4A4A4),
                          ),
                          Text(
                            'Upload Image',
                            style: kBodyText14w500(Color(0xffA4A4A4)),
                          )
                        ]),
                  )
                ],
              ),
              addVerticalSpace(5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      isAgree = !isAgree;
                      setState(() {});
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: isAgree
                          ? kGradientBoxDecoration2(10, greenGradient())
                          : k3DboxDecoration(10),
                      child: isAgree
                          ? const Icon(
                              Icons.check,
                              color: white,
                              size: 40,
                            )
                          : SizedBox(),
                    ),
                  ),
                  SizedBox(
                    width: 76.w,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'I agree with the ',
                          style: kBodyText15wNormal(black)),
                      TextSpan(
                          text: 'terms and conditions',
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: black,
                              decoration: TextDecoration.underline))
                    ])),
                  )
                ],
              ),
              addVerticalSpace(3.h),
              Text(
                '299/- Registration Fee',
                style: kBodyText20wBold(green),
              ),
              addVerticalSpace(5.h),
              CustomButton(
                  text: 'Register',
                  onTap: () {
                    nextScreen(context, RazorpayScreen());
                    nextScreen(
                        context, RegistrationSuccessfull(whoareYou: 'Teacher'));
                  }),
              addVerticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }

  pickDate() async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1947),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

      setState(() {
        datofBirthControler.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}
