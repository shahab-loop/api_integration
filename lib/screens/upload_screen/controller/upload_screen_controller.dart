import 'dart:io';
import 'package:api_integ/services/api_services.dart';
import 'package:api_integ/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreenController extends GetxController {
  // Image
  Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  // Controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final ratingController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  // State
  RxBool isFormValid = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(validateForm);
    descriptionController.addListener(validateForm);
    ratingController.addListener(validateForm);
  }

  // ✅ Validate form
  void validateForm() {
    final name = nameController.text.trim();
    final desc = descriptionController.text.trim();
    final rating = ratingController.text.trim();

    isFormValid.value =
        name.isNotEmpty &&
            desc.isNotEmpty &&
            rating.isNotEmpty &&
            int.tryParse(rating) != null &&
            selectedImage.value != null;
  }

  // ✅ Pick image (compressed)
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60, // 🔥 reduce size (important)
    );

    if (image != null) {
      selectedImage.value = File(image.path);
      validateForm();
    }
  }

  // ✅ Remove image
  void removeImage() {
    selectedImage.value = null;
    validateForm();
  }

  // ✅ Upload item (MAIN FUNCTION)
  Future<void> uploadItem() async {
    // ✅ FIX 1: Safe form check
    // if (formKey.currentState == null || !formKey.currentState!.validate()) {
    //   Get.snackbar("Error", "Please fix form errors");
    //   return;
    // }

    // ✅ FIX 2: Safe image check
    if (selectedImage.value == null) {
      Get.snackbar("Error", "Image is required");
      return;
    }

    try {
      isLoading.value = true;

      final file = selectedImage.value; // no !

      // Extra safety
      if (file == null || !(await file.exists())) {
        isLoading.value = false;
        Get.snackbar("Error", "Invalid image file");
        return;
      }

      final response = await apiService.createItem(
        nameController.text.trim(),
        descriptionController.text.trim(),
        int.tryParse(ratingController.text.trim()) ?? 0,
        file,
      );

      isLoading.value = false;

      if (response != null && response.statusCode == 200) {
        showToast("✅ Upload Successfully");
        clearForm();
      } else {
        print("Response Body: ${response?.body}");
        showToast("❌ Upload Failed");
      }
    } catch (e) {
      isLoading.value = false;
      print("Upload Error: $e");
      showToast("❌ Something went wrong");
    }
  }
  // ✅ Clear form
  void clearForm() {
    nameController.clear();
    descriptionController.clear();
    ratingController.clear();
    selectedImage.value = null;
    validateForm();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    ratingController.dispose();
    super.onClose();
  }
}