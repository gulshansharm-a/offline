import 'package:get/get.dart';
import 'package:offline_classes/Views/auth/auth_controller.dart';
import 'package:offline_classes/Views/auth/succesfull_login_screen.dart';

class OtpController extends GetxController {
  static OtpController get instace => Get.put(OtpController());

  void verifyOTP(String otp) async {
    var isVerified = await AuthController.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const SuccessfullLogInscreen()) : Get.back();
  }
}
