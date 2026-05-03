import 'package:api_integ/screens/upload_screen/controller/upload_screen_controller.dart';
import 'package:api_integ/widgets/textfieldwithsvg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadScreen extends StatelessWidget {
  static const String routeName = '/uploadScreen';
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UploadScreenController controller = Get.put(UploadScreenController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                Text(
                  "Add Fields",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormFieldWidget(
                  hintText: 'Item Name',
                  borderColor: Colors.black26,
                  controller: controller.nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Item name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormFieldWidget(
                  hintText: 'Item Description',
                  borderColor: Colors.black26,
                  controller: controller.descriptionController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Item name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormFieldWidget(
                  hintText: 'Item Rating',
                  borderColor: Colors.black26,
                  controller: controller.ratingController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Item name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Item Image",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: controller.selectedImage.value != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                controller.selectedImage.value!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload, size: 50),
                                SizedBox(height: 5),
                                Text("Tap to upload image"),
                              ],
                            ),
                    ),
                  );
                }),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    controller.uploadItem();
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child:controller.isLoading.value ? CircularProgressIndicator() : Text("Upload")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
