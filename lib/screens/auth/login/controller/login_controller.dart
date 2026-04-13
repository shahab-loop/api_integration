import 'dart:convert';
import 'dart:developer';
import 'package:api_integ/core/navigations/navigation_helper/navigation_helper.dart';
import 'package:api_integ/core/navigations/routes/routes.dart';
import 'package:api_integ/services/api_services.dart';
import 'package:api_integ/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  var isLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;
      http.Response? response = await apiService.login(
        emailController.text,
        passwordController.text,
      );
      if (response!.statusCode == 200) {
        final data = jsonDecode(response.body);
        final otp = data["otp"];
        isLoading.value = false;
        showToast('login successfully');
        NavigationHelper.navigateTo(Routes.otpVerification,arguments: {
          "email" : emailController.text,
          "otp" : otp.toString(),
        });
      } else {
        isLoading.value = false;
        showToast('login failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> login() async {
  //   try {
  //     isLoading.value = true;
  //
  //     http.Response? response = await apiService.login(
  //       emailController.text,
  //       passwordController.text,
  //     );
  //
  //     if (response != null && response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       if (kDebugMode) {
  //         print("OTP: ${data["otp"]}");
  //       }
  //       NavigationHelper.navigateTo(Routes.otpVerification,arguments: {
  //         "email": emailController.text,
  //         "otp": data["otp"],
  //       });
  //       showToast("Login success");
  //       isLoading.value = false;
  //     } else {
  //       isLoading.value = false;
  //       showToast("Login failed");
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     log("login Exception: $e");
  //     Get.snackbar("Error", e.toString());
  //   }
  // }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
