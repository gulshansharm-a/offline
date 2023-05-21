import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline_classes/Views/auth/login_screen.dart';
import 'package:offline_classes/Views/auth/otp_verify_screen.dart';
import 'package:offline_classes/global_data/GlobalData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enquiry_registrations/enquiry_student_or_teachers.dart';

class AuthController extends GetxController {
  //AuthController instance
  static AuthController get instance => Get.put(AuthController());
  //Email, password, name
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  var verificationId = "".obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    getPhoneNumber().then((phoneNumber) {
      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        // Use the phoneNumber for OTP login or any further processing
        print('Phone Number: $phoneNumber');
        GlobalData().updatePhoneNumber(phoneNumber);
        GlobalData().getInfoLogin(
            "/login", GlobalData.auth1, GlobalData.phoneNumber.substring(1));
      }
    });
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    Future.delayed(Duration(seconds: 2), () {
      // Code to be executed after the delay
      // Place your desired code here
    });
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => EnquirySelectStudentOrTeachers());
    }
  }

  Future<void> sendOTP(String phno) async {
    savePhoneNumber(phno);
    GlobalData().updatePhoneNumber(phno);
    await auth.verifyPhoneNumber(
      phoneNumber: phno,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == "invalid-phone-number") {
          Get.snackbar("Error", "Invalid Phone Number");
        } else {
          Get.snackbar("Error", "Something went wrong.");
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId.value = verificationId;
        GlobalData().updatePhoneNumber(phno);
        print("OTP Sent");
        print(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  void savePhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
  }

  Future<String?> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber');
  }

  void removePhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('phoneNumber');
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: this.verificationId.toString(), smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
