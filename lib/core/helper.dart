// import 'package:shared_preferences/shared_preferences.dart';
//
// class LocalStorage {
//   static Future<void> saveLogin({
//     required String email,
//     required String token,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//
//     await prefs.setBool("isLoggedIn", true);
//     await prefs.setString("email", email);
//     await prefs.setString("token", token);
//   }
//
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool("isLoggedIn") ?? false;
//   }
//
//   static Future<String?> getEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString("email");
//   }
//
//   static Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }
// }