import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:api_integ/utils/end_points.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  Map<String, String> get _headers => {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  /// SIGNUPMap<String, String> get _headers => {
  //     "Content-Type": "application/json",
  //     "Accept": "application/json",
  //   };
  Future<http.Response?> signup(
    String username,
    String email,
    String password,
  ) async {
    try {
      final url = Uri.parse(ApiEndpoints.signup);
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
        }),
      );

      print("===== SIGNUP RESPONSE =====");
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");
      return response;
    } catch (e) {
      print("Signup Error: $e");
      return null;
    }
  }

  /// LOGIN
  Future<http.Response?> login(
    String email,
    String password,
  ) async {
    try {
      final url = Uri.parse(ApiEndpoints.login);
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({
          "email": email.trim(),
          "password": password,
        }),
      );

      print("===== LOGIN RESPONSE =====");
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");
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
        headers: _headers,
        body: jsonEncode({"email": email.trim(), "otp": otp.trim()}),
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

  Future<http.Response?> getItems() async {
    try {
      final url = Uri.parse(ApiEndpoints.getItem);
      final response = await http.get(url, headers: _headers);
      return response;
    } catch (e) {
      print("Get Items Error: $e");
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
      request.headers.addAll({"Accept": "application/json"});

      request.fields['item_name'] = itemName;
      request.fields['item_description'] = itemDescription;
      request.fields['item_points'] = itemPoints.toString();

      String extension = itemImage.path.split('.').last.toLowerCase();
      String mimeType = 'image/jpeg';
      if (extension == 'png') mimeType = 'image/png';

      request.files.add(
        await http.MultipartFile.fromPath(
          'item_image',
          itemImage.path,
          contentType: MediaType.parse(mimeType),
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } catch (e) {
      print("Create Item Error: $e");
      return null;
    }
  }
}
