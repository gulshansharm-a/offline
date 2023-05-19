import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:offline_classes/Views/enquiry_registrations/student_registration.dart';
import 'package:offline_classes/Views/enquiry_registrations/teachers_registration_screen.dart';
import 'package:offline_classes/Views/home/home_page_for_register_user.dart';
import 'package:offline_classes/model/statics_list.dart';
import 'package:offline_classes/utils/constants.dart';
import 'package:offline_classes/widget/custom_button.dart';
import 'package:offline_classes/widget/my_bottom_navbar.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.whoAreYou,
    required this.heading,
    required this.serviceList,
    required this.sliderList,
  });
  final String whoAreYou;
  final String heading;
  final List serviceList;
  final List sliderList;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropDownValue = 'Language';
  List dropDownList = ['Language', 'English', 'Hindi'];

  int? selectedIndex;
  int? selectedIndex2;

  @override
  Widget build(BuildContext context) {
    log(widget.whoAreYou);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        foregroundColor: black,
        leadingWidth: width(context) * 0.3,
        leading: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'LOGO',
              style: kBodyText24wBold(primary),
            ),
          ),
        ),
        actions: [
          DropdownButton<String>(
            value: dropDownValue,
            hint: const Text(
              'Select',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffB1B1B3),
                  fontWeight: FontWeight.w400),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: black,
              size: 26,
            ),
            // elevation: 10,
            style: const TextStyle(
                color: black, fontSize: 18, fontWeight: FontWeight.w500),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            // isExpanded: true,s
            underline: SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                dropDownValue = newValue!;
              });
            },
            items: dropDownList.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome To Trusir',
                    style: TextStyle(
                        color: blue,
                        fontSize: 40.sp,
                        height: 1.1,
                        fontWeight: FontWeight.w800),
                  ),
                  addVerticalSpace(10),
                  Text(
                    widget.heading,
                    style: kBodyText22wNormal(blue),
                  ),
                  addVerticalSpace(15),
                  SizedBox(
                    height: 31.h,
                    child: ListView.builder(
                        itemCount: widget.sliderList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            height: height(context) * 0.3,
                            width: width(context) * 0.6,
                            decoration: kFillBoxDecoration(
                                0,
                                i % 2 == 0
                                    ? Color.fromRGBO(255, 28, 246, 0.15)
                                    : Color.fromRGBO(255, 28, 246, 0.1),
                                0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  child:
                                      Image.asset('assets/images/loginimg.png'),
                                ),
                                addVerticalSpace(6),
                                Text(
                                  widget.sliderList[i],
                                  style: kBodyText18wBold(primary2),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  addVerticalSpace(15),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          widget.whoAreYou == 'Student'
                              ? nextScreen(context, StudentRegistration())
                              : nextScreen(context, TeacherRegistration());
                        },
                        child: Text(
                          'Click here for registration',
                          style: kBodyText20wBold(primary2),
                        )),
                  ),
                  addVerticalSpace(10),
                  Text(
                    'Our Services',
                    style: kBodyText24wBold(primary),
                  ),
                  addVerticalSpace(15),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.serviceList.length,
                      itemBuilder: (ctx, i) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                          height: height(context) * 0.25,
                          width: width(context) * 0.95,
                          decoration: kFillBoxDecoration(
                              0,
                              i % 2 == 0
                                  ? Color.fromRGBO(12, 131, 218, 0.16)
                                  : Color.fromRGBO(255, 28, 246, 0.1),
                              0),
                          child: i % 2 == 0
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 48.w,
                                      child: Image.asset(
                                          'assets/images/loginimg.png'),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // addVerticalSpace(15),
                                        SizedBox(
                                          width: 40.w,
                                          child: Text(
                                            widget.serviceList[i]['title'],
                                            style: kbodyText18W600(i % 2 == 0
                                                ? Color(0xff0C3D45)
                                                : Color(0xff620085)),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        addVerticalSpace(10),
                                        SizedBox(
                                          width: 40.w,
                                          child: Text(
                                            widget.serviceList[i]['subtitle'],
                                            style: kBodyText14wNormal(i % 2 == 0
                                                ? Color(0xff0A595B)
                                                : Color(0xffA400DE)),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                    addHorizontalySpace(0)
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // addVerticalSpace(15),
                                        SizedBox(
                                          width: 40.w,
                                          child: Text(
                                            widget.serviceList[i]['title'],
                                            style: kbodyText18W600(i % 2 == 0
                                                ? Color(0xff0C3D45)
                                                : Color(0xff620085)),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        addVerticalSpace(10),
                                        SizedBox(
                                          width: 40.w,
                                          child: Text(
                                            widget.serviceList[i]['subtitle'],
                                            style: kBodyText14wNormal(i % 2 == 0
                                                ? Color(0xff0A595B)
                                                : Color(0xffA400DE)),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      // height: height(context) * 0.19,
                                      width: 48.w,
                                      child: Image.asset(
                                          'assets/images/loginimg.png'),
                                    ),
                                  ],
                                ),
                        );
                      }),
                  addVerticalSpace(8),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          widget.whoAreYou == 'Student'
                              ? nextScreen(context, StudentRegistration())
                              : nextScreen(context, TeacherRegistration());
                        },
                        child: Text(
                          'Click here for registration',
                          style: kBodyText20wBold(primary2),
                        )),
                  ),
                  addVerticalSpace(10),
                  Text(
                    'Get the Best Tutor for your child',
                    style: kBodyText27wBold(black),
                  ),
                  addVerticalSpace(3.h),
                  Text(
                    'Get the best learning support for your child',
                    style: kBodyText24wBold(Color(0xffBCBCBC)),
                  ),
                  addVerticalSpace(2.h),
                  Text(
                    'For all your learning support needs such as homework, test, school project and examinations; we are here to give you the best support.',
                    style: kBodyText20wNormal(black),
                  ),
                  addVerticalSpace(10),
                  Text(
                    'The best tutors are here',
                    style: kBodyText24wBold(Color(0xffBCBCBC)),
                  ),
                  addVerticalSpace(1.5.h),
                  Text(
                    'Our tutors are seasoned professionals, screened and given relevant trainings on monthly basis to deliver the excellent results you desire.',
                    style: kBodyText20wNormal(black),
                  ),
                  addVerticalSpace(2.h),
                  Image.asset('assets/images/best1.png'),
                  addVerticalSpace(15),
                  Image.asset('assets/images/best2.png'),
                  addVerticalSpace(2.h),
                  Text(
                    'Explore our offerings',
                    style: kBodyText24wBold(primary),
                  ),
                  addVerticalSpace(10),
                  Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: List.generate(offeringList.length, (i) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = i;
                          setState(() {});
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: selectedIndex == i
                              ? kFillBoxDecoration(0, Color(0xff793EFF), 30)
                              : kOutlineBoxDecoration(1, Color(0xff793EFF), 30),
                          child: Text(
                            offeringList[i],
                            style: kBodyText15wNormal(
                                selectedIndex == i ? white : black),
                          ),
                        ),
                      );
                    }),
                  ),
                  addVerticalSpace(15),
                  Text(
                    'Explore Subjects',
                    style: kBodyText24wBold(primary),
                  ),
                  addVerticalSpace(2.h),
                  Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: List.generate(subjectList.length, (i) {
                      return InkWell(
                        onTap: () {
                          selectedIndex2 = i;
                          setState(() {});
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: selectedIndex2 == i
                              ? kFillBoxDecoration(0, Color(0xff793EFF), 30)
                              : kOutlineBoxDecoration(1, Color(0xff793EFF), 30),
                          child: Text(
                            subjectList[i],
                            style: kBodyText15wNormal(
                                selectedIndex2 == i ? white : black),
                          ),
                        ),
                      );
                    }),
                  ),
                  addVerticalSpace(height(context) * 0.05),
                  CustomButton(
                      text: 'Registration',
                      onTap: () {
                        widget.whoAreYou == 'Student'
                            ? nextScreen(context, StudentRegistration())
                            : nextScreen(context, TeacherRegistration());
                      }),
                  addVerticalSpace(3.5.h),
                  Center(
                    child: Text(
                      'Get In Touch',
                      style: kBodyText24wBold(Color(0xff48116A)),
                    ),
                  ),
                  addVerticalSpace(3.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 6.5.h,
                        width: 15.w,
                        decoration: k3DboxDecoration(15),
                        child: const Center(
                          child: Icon(
                            Icons.call,
                            size: 30,
                            color: Color(0xff48116A),
                          ),
                        ),
                      ),
                      addHorizontalySpace(6.w),
                      Text(
                        '020-28438294',
                        style: kBodyText18wNormal(black),
                      )
                    ],
                  ),
                  addVerticalSpace(2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 6.5.h,
                        width: 15.w,
                        decoration: k3DboxDecoration(15),
                        child: const Center(
                          child: Icon(
                            Icons.mail,
                            size: 30,
                            color: Color(0xff48116A),
                          ),
                        ),
                      ),
                      addHorizontalySpace(6.w),
                      Text(
                        'abcd1234@gmail.com',
                        style: kBodyText18wNormal(black),
                      )
                    ],
                  ),
                  addVerticalSpace(2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 6.5.h,
                        width: 15.w,
                        decoration: k3DboxDecoration(15),
                        child: const Center(
                            child: ImageIcon(
                          AssetImage('assets/images/wpicon.png'),
                          size: 30,
                        )),
                      ),
                      addHorizontalySpace(6.w),
                      Text(
                        '08346728197',
                        style: kBodyText18wNormal(black),
                      )
                    ],
                  ),
                  addVerticalSpace(2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 6.5.h,
                        width: 15.w,
                        decoration: k3DboxDecoration(15),
                        child: const Center(
                          child: Icon(
                            Icons.location_on,
                            size: 30,
                            color: Color(0xff48116A),
                          ),
                        ),
                      ),
                      addHorizontalySpace(6.w),
                      Text(
                        'Bihar',
                        style: kBodyText18wNormal(black),
                      )
                    ],
                  ),
                  addVerticalSpace(3.5.h),
                  Center(
                    child: Text(
                      'Follow Us On',
                      style: kBodyText24wBold(Color(0xff48116A)),
                    ),
                  ),
                  addVerticalSpace(3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          height: 6.1.h,
                          child: Image.asset('assets/images/insta.png')),
                      SizedBox(
                          height: 6.h,
                          child: Image.asset('assets/images/fb.png')),
                      SizedBox(
                          height: 6.h,
                          child: Image.asset('assets/images/utube.png')),
                    ],
                  ),
                  addVerticalSpace(3.h),
                ],
              ),
            ),
            Container(
              height: 10.h,
              width: width(context),
              // decoration: kGradientBoxDecoration(0, purpleGradident()),
              decoration: kFillBoxDecoration(0, Color(0xff48116a), 0),
              child: Center(
                child: Text(
                  'www.trusir.com',
                  style: kBodyText27wNormal(white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
