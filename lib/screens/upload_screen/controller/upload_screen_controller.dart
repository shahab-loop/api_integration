import 'dart:io';
import 'package:api_integ/services/api_services.dart';
import 'package:api_integ/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreenController extends GetxController {

  Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final ratingController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  RxBool isFormValid = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(validateForm);
    descriptionController.addListener(validateForm);
    ratingController.addListener(validateForm);
  }

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

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (image != null) {
      selectedImage.value = File(image.path);
      validateForm();
    }
  }


  void removeImage() {
    selectedImage.value = null;
    validateForm();
  }


  Future<void> uploadItem() async {

    if (selectedImage.value == null) {
      Get.snackbar("Error", "Image is required");
      return;
    }

    try {
      isLoading.value = true;

      final file = selectedImage.value;

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