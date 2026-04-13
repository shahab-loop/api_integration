import 'dart:developer';
import 'package:api_integ/services/api_services.dart';
import 'package:api_integ/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  var isLoading = false.obs;

  Future<void> signup() async {
    try {
      isLoading.value = true;

      http.Response? response = await apiService.signup(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      if(response!.statusCode == 200){
        isLoading.value = false;
        showToast("Signup successfully");
      } else {
        isLoading.value = false;
        showToast("Signup failed");
      }
    } catch (e) {
      log("Signup Exception: $e");
      Get.snackbar("Error", e.toString());

    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
