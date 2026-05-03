import 'package:api_integ/core/navigations/navigation_helper/navigation_helper.dart';
import 'package:api_integ/core/navigations/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      NavigationHelper.navigateTo(Routes.homeScreen);

      print("===== LOGIN SUCCESS =====");
      print("UID: ${userCredential.user?.uid}");
      print("Email: ${userCredential.user?.email}");

      Get.snackbar("Success", "Login successful");

    } on FirebaseAuthException catch (e) {
      print("LOGIN ERROR: ${e.message}");
      Get.snackbar("Error", e.message ?? "Login failed");

    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}