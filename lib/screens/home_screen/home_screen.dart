import 'package:api_integ/core/navigations/navigation_helper/navigation_helper.dart';
import 'package:api_integ/core/navigations/routes/routes.dart';
import 'package:api_integ/screens/home_screen/controller/home_controller.dart';
import 'package:api_integ/widgets/info_card_widget.dart';
import 'package:api_integ/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/homeScreen';

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              NavigationHelper.navigateTo(Routes.uploadScreen);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(Icons.drive_folder_upload, color: Colors.black),
            ),
          ),
        ],
        title: const Text("Items List"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              return const ShimmerEffect();
            },
          );

        }

        if (controller.infoList.isEmpty) {
          return const Center(child: Text("No items found"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchItems(),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.infoList.length,
            itemBuilder: (context, index) {
              final item = controller.infoList[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InfoCardWidget(
                  isNetworkImage: true,
                  image: item.itemImage,
                  name: item.itemName,
                  description: item.itemDescription,
                  time: controller.getTimeAgo(item.createdTime.toString()),
                  color: Colors.blueAccent,
                  rating: item.itemPoints.toString(),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
