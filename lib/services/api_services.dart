import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:api_integ/utils/end_points.dart';
import 'package:http_parser/http_parser.dart'; // Import this

class ApiService {
  /// SIGNUP
  Future<http.Response?> signup(
    String username,
    String email,
    String password,
  ) async {
    try {
      final url = Uri.parse(ApiEndpoints.signup);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
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
  Future<http.Response?> login(
    String email,
    // String otp,
    String password,
  ) async {
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
        body: jsonEncode({"email": email, "otp": otp}),
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

  Future<http.Response?> createItem(
    String itemName,
    String itemDescription,
    int itemPoints,
    File itemImage,
  ) async {
    try {
      final url = Uri.parse(ApiEndpoints.createItem);

      var request = http.MultipartRequest("POST", url);

      request.fields['item_name'] = itemName;
      request.fields['item_description'] = itemDescription;
      request.fields['item_points'] = itemPoints.toString();

      // Get extension
      String extension = itemImage.path.split('.').last.toLowerCase();
      // Default to jpeg if unknown
      String mimeType = 'image/jpeg';
      if (extension == 'png') mimeType = 'image/png';
      if (extension == 'jpg' || extension == 'jpeg') mimeType = 'image/jpeg';

      request.files.add(
        await http.MultipartFile.fromPath(
          'item_image',
          itemImage.path,
          contentType: MediaType.parse(mimeType), // Specify content type
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");

      return response;
    } catch (e) {
      print("Create Item Error: $e");
      return null;
    }
  }
}
