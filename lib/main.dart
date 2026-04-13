import 'package:api_integ/core/navigations/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:api_integ/core/navigations/app_routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My App",
      initialRoute: Routes.loginScreen,
      getPages: AppRoutes.pages,
    );
  }
}