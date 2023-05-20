import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline_classes/Views/auth/login_screen.dart';
import 'package:offline_classes/Views/auth/otp_verify_screen.dart';

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
    StreamSubscription<User?> userSubscription = _user.listen((user) {
      // Check if the user has provided a phone number for OTP login
      if (user!.phoneNumber != null && user.phoneNumber!.isNotEmpty) {
        String phoneNumber =
            user!.phoneNumber != null ? (user.phoneNumber as String) : "";
        // Use the phoneNumber for OTP login or any further processing
        print('Phone Number: $phoneNumber');
      }
    });
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => EnquirySelectStudentOrTeachers());
    }
  }

  Future<void> sendOTP(String phno) async {
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
        print("OTP Sent");
        print(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
      },
    );
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
