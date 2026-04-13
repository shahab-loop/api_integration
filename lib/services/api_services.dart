import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_integ/utils/end_points.dart';

class ApiService {

  /// SIGNUP
  Future<http.Response?> signup(String username, String email,
      String password) async {
    try {
      final url = Uri.parse(ApiEndpoints.signup);

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
        }),
      );

      // 🔹 Print response in console
      print("===== SIGNUP RESPONSE =====");
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");
      print("============================");

      return response;
    } catch (e) {
      print("Signup Error: $e");
      return null;
    }
  }

/// LOGIN
  Future<http.Response?> login(String email,
      // String otp,
      String password) async {
    try {
      final url = Uri.parse(ApiEndpoints.login);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          // "otp": otp,
          "password": password,
        }),
      );

      print("===== LOGIN RESPONSE =====");
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");
      print("============================");

      return response;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }
/// OTP VERIFICATION
  Future<http.Response?> otpVerification(String email, String otp) async {
    try {
      final url = Uri.parse(ApiEndpoints.otpVerify);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );

      print("===== OTP RESPONSE =====");
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");

      return response;
    } catch (e) {
      print("OTP Error: $e");
      return null;
    }
  }
}