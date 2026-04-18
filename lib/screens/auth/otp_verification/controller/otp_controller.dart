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

class OtpController extends GetxController {
  final ApiService apiService = ApiService();
  final otpController = TextEditingController();
  var isLoading = false.obs;
  String? email;
  String? otp;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments["email"];
    otp = Get.arguments["otp"];
    log("Email: $email");
    log("OTP: $otp");
    otpController.text = otp.toString();
  }


  Future<void> otpVerification() async {
    try {
      isLoading.value = true;
      http.Response? response = await apiService.otpVerification(
        email.toString(),
        otp.toString(),
      );

      if (response != null && response.statusCode == 200) {
        jsonDecode(response.body);
        showToast("Otp Verify successfully");
        NavigationHelper.navigateTo(Routes.homeScreen);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showToast("Otp failed");
      }
    } catch (e) {
      isLoading.value = false;
      log("Otp Exception: $e");
      Get.snackbar("Error", e.toString());
    }
  }

  void resendOtp() {
    Get.snackbar("OTP Sent", "OTP resent successfully");
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}