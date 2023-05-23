import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Views/enquiry_registrations/enquiry_student_or_teachers.dart';
import '../global_data/GlobalData.dart';
import '../widget/my_bottom_navbar.dart';

class ProgressIndicatorScreen extends StatelessWidget {
  const ProgressIndicatorScreen({super.key});

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
            if (role == 'student' || role == 'teacher') {
              return MyBottomBar(whoRYou: role);
            } else {
              // return MyBottomBar(whoRYou: role);
              return EnquirySelectStudentOrTeachers();
            }
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
