import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:offline_classes/Views/enquiry_registrations/payment_method.dart';
import 'package:offline_classes/Views/enquiry_registrations/registration_successfull.dart';
import 'package:offline_classes/model/statics_list.dart';
import 'package:offline_classes/razorpay_payments/razorpay_screen.dart';
import 'package:offline_classes/utils/my_appbar.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';
import '../../widget/custom_item_seleted_field.dart';
import '../../widget/custom_textfield.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  final TextEditingController datofBirthControler = TextEditingController();
  String drodownValue = 'Gender';
  String classValue = 'Class';
  String stateValue = 'State';
  String cityValue = 'City/Town';

  List genderList = ['Gender', 'Male', 'Female', 'Others'];
  bool isSelect = false;
  bool isMedium = false;
  bool isSubject = false;
  bool isAgree = false;
  int? selectStudent;
  int? selectMedium;
  int? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar2(context, ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              addVerticalSpace(10),
              Container(
                height: 32.h,
                width: width(context) * 0.95,
                decoration: kGradientBoxDecoration(42, purpleGradident()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 22.h,
                        child: Image.asset('assets/images/student2.png')),
                    Text(
                      'Student Registration',
                      style: kBodyText25Bold(white),
                    )
                  ],
                ),
              ),
              addVerticalSpace(20),
              CustomItemSelectedField(
                onTap: () {
                  isSelect = !isSelect;
                  setState(() {});
                },
                title: 'No. of Students',
                isChanged: isSelect,
              ),
              if (isSelect)
                Column(
                  children: [
                    addVerticalSpace(10),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return Row(
                              children: [
                                addHorizontalySpace(10),
                                InkWell(
                                  onTap: () {
                                    selectStudent = i;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: selectStudent == i
                                        ? kGradientBoxDecoration2(
                                            10, greenGradient())
                                        : k3DboxDecoration(10),
                                    child: selectStudent == i
                                        ? const Icon(
                                            Icons.check,
                                            color: white,
                                            size: 40,
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                                addHorizontalySpace(15),
                                Text(
                                  '${i + 1}',
                                  style: kBodyText16wNormal(textColor),
                                ),
                                addHorizontalySpace(10.w)
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              addVerticalSpace(15),
              CustomTextfield(hintext: 'Student Name'),
              addVerticalSpace(15),
              CustomTextfield(hintext: "Father's Name"),
              addVerticalSpace(15),
              CustomTextfield(hintext: "Mother's Name"),
              addVerticalSpace(15),
              Row(
                children: [
                  Container(
                    height: 8.5.h,
                    width: width(context) * 0.45,
                    padding:
                        EdgeInsets.symmetric(horizontal: 9.w, vertical: 10),
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
                              color: Color(0xffA4A4A4),
                              fontWeight: FontWeight.w500),
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: textColor,
                          size: 30,
                        ),
                        // elevation: 10,
                        style: const TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
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
                              style: kBodyText14w500(textColor),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    // height: 6.5.h,
                    width: width(context) * 0.45,
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
              CustomTextfield(hintext: "School Name"),
              addVerticalSpace(15),
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
                    value: classValue,
                    hint: const Text(
                      'Select',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffA4A4A4),
                          fontWeight: FontWeight.w500),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: textColor,
                      size: 30,
                    ),
                    // elevation: 10,
                    style: const TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    isExpanded: true,
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        classValue = newValue!;
                      });
                    },
                    items: classDropdownList
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
              CustomItemSelectedField(
                onTap: () {
                  isSubject = !isSubject;
                  setState(() {});
                },
                title: 'Subject',
                isChanged: isSubject,
              ),
              if (isSubject)
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
                    value: stateValue,
                    hint: const Text(
                      'Select',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffA4A4A4),
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
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
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
                  addHorizontalySpace(2),
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
                    // nextScreen(
                    //     context,
                    //     RegistrationSuccessfull(
                    //       whoareYou: 'Student',
                    //     ));
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
