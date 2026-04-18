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
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ApiService apiService = ApiService();


  @override
  void onInit() {
    super.onInit();
    checkLogin(); // ✅ call async function
  }

  Future<void> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? loginValue = prefs.getString('login');

    if (loginValue != null && loginValue.isNotEmpty) {
      print("User already logged in: $loginValue");
      NavigationHelper.removeAllAndNavigateTo(Routes.homeScreen);
    } else {
      print("User not logged in");
    }
  }
  var isLoading = false.obs;
   Future<void> login () async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     try{isLoading.value = true;
       http.Response? response = await apiService.login(
         emailController.text,
         passwordController.text
       );
       if(response!.statusCode == 200){
        isLoading.value = false ;
        showToast("Login Successfully");
        final data = jsonDecode(response.body);
        final otp = data["otp"];
        NavigationHelper.navigateTo(Routes.otpVerification,arguments: {
          "email":emailController.text,
          "otp":otp
        });
        prefs.setString('login', emailController.text);
       }else{
         isLoading.value = false ;
         showToast("Login Failed");
       }

     }catch(e){print("Error");

     }

   }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
