import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:offline_classes/Views/enquiry_registrations/ztest.dart';
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
  bool showSpinner = false;

  double studentFees = 299.00;

  List<TextEditingController> createTextControllers(int count) {
    List<TextEditingController> list = [];
    for (int i = 0; i < count; i++) {
      list.add(TextEditingController());
    }
    return list;
  }

  @override
  void initState() {
    getAllImages();
    super.initState();
  }

  List imageNames = [
    "Photo",
    "Aadhar Card",
    "Signatures",
  ];

  final List<TextEditingController> datofBirthControler = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> nameController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> fnameController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> mnameController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> cityController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> pinController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final List<TextEditingController> schoolController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final List<TextEditingController> caddController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final List<TextEditingController> paddController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final List<TextEditingController> phnoController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final List<TextEditingController> areaController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<String> gender = ["Gender", "Gender", "Gender"];
  final List<String> medium = ["Hindi", "Hindi", "Hindi"];
  final List<String> classes = ["Class", "Class", "Class"];
  final List<String> subject = ["Hindi", "Hindi", "Hindi"];
  final List<String> state = ["State", "State", "State"];

  List<File?> photo = List<File?>.filled(3, null);
  List<File?> aadhar = List<File?>.filled(3, null);
  List<File?> signature = List<File?>.filled(3, null);

  List genderList = ['Gender', 'Male', 'Female', 'Others'];
  bool isSelect = false;
  bool isMedium = false;
  bool isSubject = false;
  bool isAgree = false;
  int? selectStudent;
  List<int> selectMedium = [0, 0, 0];
  List<int?> selectedSubject = [0, 0, 0];

  List<List<File?>> allImages = [
    List<File?>.filled(3, null),
    List<File?>.filled(3, null),
    List<File?>.filled(3, null)
  ];

  getAllImages() {
    allImages = [photo, aadhar, signature];
  }

  ImagePicker _picker = ImagePicker();

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
              Column(
                children: <Widget>[
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
                                        setState(() {
                                          selectStudent = i + 1;
                                        });
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        decoration: selectStudent == i + 1
                                            ? kGradientBoxDecoration2(
                                                10, greenGradient())
                                            : k3DboxDecoration(10),
                                        child: selectStudent == i + 1
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
                ],
              ),
              Column(
                children: List.generate(
                  selectStudent ?? 1,
                  (index) {
                    return Column(
                      children: <Widget>[
                        Text(
                          'Student ${index + 1}',
                          style: kBodyText25Bold(black),
                        ),
                        addVerticalSpace(15),
                        CustomTextfield(
                            controller: nameController[index],
                            hintext: 'Student Name'),
                        addVerticalSpace(15),
                        CustomTextfield(
                            controller: fnameController[index],
                            hintext: "Father's Name"),
                        addVerticalSpace(15),
                        CustomTextfield(
                            controller: mnameController[index],
                            hintext: "Mother's Name"),
                        addVerticalSpace(15),
                        Row(
                          children: [
                            Container(
                              height: 8.5.h,
                              width: width(context) * 0.45,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 9.w, vertical: 10),
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
                                  value: gender[index],
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      gender[index] = newValue!;
                                    });
                                  },
                                  items: genderList
                                      .map<DropdownMenuItem<String>>((value) {
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
                                controller: datofBirthControler[index],
                                onTap: () {
                                  pickDate(index);
                                },
                                hintext: 'DOB',
                                sufixIcon: Icons.calendar_month,
                              ),
                            )
                          ],
                        ),
                        addVerticalSpace(15),
                        CustomTextfield(
                          controller: phnoController[index],
                          hintext: "Phone Number",
                          keyBoardType: TextInputType.number,
                        ),
                        addVerticalSpace(15),
                        CustomTextfield(
                          controller: schoolController[index],
                          hintext: "School Name",
                        ),
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
                                              selectMedium[index] = i;
                                              setState(() {
                                                medium[index] = mediumList[i];
                                              });
                                            },
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration:
                                                  selectMedium[index] == i
                                                      ? kGradientBoxDecoration2(
                                                          10, greenGradient())
                                                      : k3DboxDecoration(10),
                                              child: selectMedium[index] == i
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
                                            style:
                                                kBodyText16wNormal(textColor),
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
                          padding:
                              EdgeInsets.only(left: 9.w, top: 7, right: 9.w),
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
                              value: classes[index],
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  classes[index] = newValue!;
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
                                              selectedSubject[index] = i;
                                              setState(() {
                                                subject[index] =
                                                    subjectList2[i];
                                              });
                                            },
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration:
                                                  selectedSubject[index] == i
                                                      ? kGradientBoxDecoration2(
                                                          10, greenGradient())
                                                      : k3DboxDecoration(10),
                                              child: selectedSubject[index] == i
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
                                              style:
                                                  kBodyText12wBold(textColor),
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
                          padding:
                              EdgeInsets.only(left: 9.w, top: 7, right: 9.w),
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
                              value: state[index],
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  state[index] = newValue!;
                                });
                              },
                              items: indianStates
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
                        CustomTextfield(
                            controller: cityController[index], hintext: "City"),
                        addVerticalSpace(15),
                        CustomTextfield(
                            controller: areaController[index],
                            hintext: "Mohalla/Area"),
                        addVerticalSpace(15),
                        CustomTextfield(
                            controller: pinController[index],
                            hintext: "Pincode",
                            keyBoardType: TextInputType.number),
                        addVerticalSpace(15),
                        CustomTextfieldMaxLine(
                          hintext: 'Current Full Address',
                          controller: caddController[index],
                        ),
                        addVerticalSpace(15),
                        CustomTextfieldMaxLine(
                          hintext: 'Permanent Full Address',
                          controller: paddController[index],
                        ),
                        addVerticalSpace(25),
                        Column(
                          children: List.generate(3, (ind) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      imageNames[ind],
                                      style: kBodyText16wBold(black),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final pickedFile =
                                            await _picker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 80,
                                        );

                                        if (pickedFile != null) {
                                          File image = File(pickedFile.path);
                                          allImages[ind][index] = image;
                                          setState(() {
                                            showSpinner = false;
                                          });
                                        } else {
                                          print("No image selected");
                                        }
                                      },
                                      child: Container(
                                        height: 7.h,
                                        width: 55.w,
                                        decoration: k3DboxDecoration(14),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.upload,
                                                size: 30,
                                                color: allImages[ind][index] ==
                                                        null
                                                    ? Color(0xffA4A4A4)
                                                    : Colors.transparent,
                                              ),
                                              Text(
                                                allImages[ind][index] == null
                                                    ? 'Upload Image'
                                                    : "Uploaded",
                                                style: kBodyText14w500(
                                                    Color(0xffA4A4A4)),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                                addVerticalSpace(20),
                              ],
                            );
                          }),
                        ),
                        addVerticalSpace(20),
                      ],
                    );
                  },
                ),
              ),
              addVerticalSpace(2.h),
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
                '${studentFees.toString()}/- Registration Fee',
                style: kBodyText20wBold(green),
              ),
              addVerticalSpace(5.h),
              CustomButton(
                text: 'Register',
                onTap: () {
                  if (isAgree == true) {
                    try {
                      String text = selectStudent.toString() + "\n";
                      for (var i = 0; i < (selectStudent ?? 1); i++) {
                        for (var j = 0; j < 3; j++) {
                          text += "${allImages[j][i]!.path}\n\n" + "1111";
                        }
                      }
                    } catch (e) {
                      Get.snackbar(
                        "Error",
                        "Select Images",
                        backgroundGradient: purpleGradident(),
                      );
                    }
                    nextScreen(context, RazorpayScreen(amount: studentFees));
                  } else {
                    Get.snackbar(
                      "Error",
                      "Agree to the terms and conditions",
                      backgroundGradient: purpleGradident(),
                    );
                  }
                },
              ),
              addVerticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }

  pickDate(int index) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1947),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

      setState(() {
        datofBirthControler[index].text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}
