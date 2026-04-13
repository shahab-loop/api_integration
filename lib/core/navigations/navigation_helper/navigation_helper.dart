import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Use this navigation helper for all the navigation (Don't use get.to etc directly in the code.)

class NavigationHelper {
  static void navigateTo(String route, {dynamic arguments, Map<String, String>? parameters}) {
    Get.toNamed(route, arguments: arguments, parameters: parameters);
  }

  static void replaceWith(String route, {dynamic arguments}) {
    Get.offNamed(route, arguments: arguments);
  }

  static void removeAllAndNavigateTo(String route, {dynamic arguments}) {
    Get.offAllNamed(route, arguments: arguments);
  }

  static void goBack() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    } else {
      Get.back();
    }
  }

  static void navigateWithCondition(String route,
      {dynamic arguments, required bool Function() condition}) {
    if (condition()) {
      navigateTo(route, arguments: arguments);
    } else {
      Get.snackbar(
          'Access Denied', 'You do not have permission to access this page',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static void navigateAfterCheck(String route,
      {dynamic arguments, required Future<bool> Function() check}) async {
    final bool canNavigate = await check();
    if (canNavigate) {
      navigateTo(route, arguments: arguments);
    } else {
      Get.snackbar(
          'Access Denied', 'You do not have permission to access this page',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  static void navigateUntil(String route,
      {dynamic arguments, required bool Function(Route<dynamic>) predicate}) {
    Get.until(predicate);
    navigateTo(route, arguments: arguments);
  }

  static void navigateRemoveUntil(String route,
      {dynamic arguments, int screensToRemove = 2}) {
    int screensRemoved = 0;

    Get.until((route) {
      screensRemoved++;
      return screensRemoved > screensToRemove;
    });

    Get.toNamed(route, arguments: arguments);
  }
}