import 'package:api_integ/core/bindings/bindings.dart';
import 'package:api_integ/core/navigations/routes/routes.dart';
import 'package:api_integ/screens/auth/login/login_screen.dart';
import 'package:api_integ/screens/auth/otp_verification/otp_verification.dart';
import 'package:api_integ/screens/auth/sign_up/signup_screen.dart';
import 'package:get/get.dart';
class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.loginScreen,
      binding: LoginScreenBinding(),
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.signupScreen,
      binding: SignupScreenBinding(),
      page: () => SignupScreen(),
    ),
    GetPage(
      name: Routes.otpVerification,
      binding: OtpVerificationBinding(),
      page: () => OtpVerification(),
    ),
  ];
}
