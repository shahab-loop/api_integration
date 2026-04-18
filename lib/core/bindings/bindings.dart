import 'package:api_integ/screens/auth/login/controller/login_controller.dart';
import 'package:api_integ/screens/auth/otp_verification/controller/otp_controller.dart';
import 'package:api_integ/screens/auth/sign_up/controller/signup_controller.dart';
import 'package:api_integ/screens/home_screen/controller/home_controller.dart';
import 'package:api_integ/screens/upload_screen/controller/upload_screen_controller.dart';
import 'package:get/get.dart';


class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
class SignupScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}
class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}
class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
class UploadScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UploadScreenController());
  }
}
