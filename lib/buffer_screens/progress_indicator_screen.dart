import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:offline_classes/Views/enquiry_registrations/enquiry_screens/enquiry_both.dart';
import 'package:offline_classes/Views/home/home_page_for_register_user.dart';
import 'package:offline_classes/Views/home/home_screen.dart';
import 'package:offline_classes/Views/home/students_facilities/select_student_profile.dart';
import 'package:offline_classes/razorpay_payments/razorpay_screen.dart';

import '../Views/enquiry_registrations/enquiry_student_or_teachers.dart';
import '../global_data/GlobalData.dart';
import '../model/statics_list.dart';
import '../widget/my_bottom_navbar.dart';
import 'package:http/http.dart' as http;

class ProgressIndicatorScreen extends StatefulWidget {
  const ProgressIndicatorScreen({super.key});

  @override
  State<ProgressIndicatorScreen> createState() =>
      _ProgressIndicatorScreenState();
}

class _ProgressIndicatorScreenState extends State<ProgressIndicatorScreen> {
  Future<void> checkForRegister() async {
    var url = Uri.parse(
        // 'https://trusher.shellcode.co.in/api/registerCheck?mobile=${GlobalData.phoneNumber.substring(1)}&authKey=${GlobalData.auth1}&role=${GlobalData.role}');
        'https://trusher.shellcode.co.in/api/registerCheck?mobile=918577098983&authKey=C4NX7IelyDl14flZGWcwDrhymzMnTcYV93dYtwfcVC1O7yabAT2Uexsd4ku7L9vlxd5nWrJDsPOfEfdDjfBGnl0ekg9droyLaPrn&role=${role}');
    var res = await http.get(url);
    if (res.body.isNotEmpty) {
      mapres = json.decode(res.body);
      registerCheck = mapres["Message"];
      print(registerCheck);
    } else {
      registerCheck = "${GlobalData.role} not Registerd";
    }
  }

  String role = GlobalData.role;

  @override
  initState() {
    print(GlobalData.phoneNumber);
    print(role);
  }

  String registerCheck = "";

  Map<String, dynamic> mapres = {};

  void _startDelayedTask() {
    Future.delayed(Duration(seconds: 5)).then((_) {
      // Code to be executed after the delay
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GlobalData().getInfoLogin(
            "/login", GlobalData.auth1, GlobalData.phoneNumber.substring(1)),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            String role = GlobalData.role;
            print(role);
            print("omg = " + role);
            //checkForRegister();
            _startDelayedTask();
            registerCheck = GlobalData.mapRegisterCheck["Message"];
            print(registerCheck);
            if (role == 'student' || role == 'teacher') {
              if (registerCheck == "Paymnet not done yert") {
                print(GlobalData.mapRegisterCheck["Amount"].toDouble());
                return RazorpayScreen(
                  amount: GlobalData.mapRegisterCheck["Amount"].toDouble(),
                  role: role,
                  payment_type: role == 'student'
                      ? "student registration"
                      : "teacher registration",
                );
              } else if (registerCheck == "Student not Registerd") {
                return HomeScreen(
                  whoAreYou: 'student',
                  serviceList: studentServiceList,
                  sliderList: const [
                    'Trusted Teachers',
                    'Home to Home tuition service'
                  ],
                  heading:
                      'Trusir is a registered and trusted Indian company that offers Home to Home tuition service. We have a clear vision of helping students achieve their academic goals through one-to-one teaching.',
                );
              } else if (registerCheck == "Teacher not Registerd") {
                return HomeScreen(
                  whoAreYou: 'teacher',
                  serviceList: teacherServiceList,
                  sliderList: const [
                    'Trusted Teachers',
                    'Home to Home tuition service'
                  ],
                  heading:
                      'Trusir is a registered and trusted Indian company that offers Home to Home tuition service. We have a clear vision of helping students achieve their academic goals through one-to-one teaching.',
                );
              } else if (registerCheck == "Teacher Registerd" ||
                  registerCheck == "Student Registerd") {
                return SelectStudentProfile();
              } else {
                const EnquirySelectStudentOrTeachers();
              }
            } else {
              return const EnquiryBoth();
            }
            return const EnquiryBoth();
          }
        },
      ),
    );
  }
}
