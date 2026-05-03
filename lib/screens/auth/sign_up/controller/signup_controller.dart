import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> signup() async {
    try {
      isLoading.value = true;

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );


      print("===== USER CREATED SUCCESSFULLY =====");
      print("UID: ${userCredential.user?.uid}");
      print("Email: ${userCredential.user?.email}");
      print("Name: ${nameController.text}");

      Get.snackbar("Success", "Account created successfully");

    } on FirebaseAuthException catch (e) {
      print("ERROR: ${e.message}");
      Get.snackbar("Error", e.message ?? "Signup failed");

    } finally {
      isLoading.value = false;
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