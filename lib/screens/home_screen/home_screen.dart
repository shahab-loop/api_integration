import 'package:api_integ/core/models/info_model.dart';
import 'package:api_integ/core/navigations/navigation_helper/navigation_helper.dart';
import 'package:api_integ/core/navigations/routes/routes.dart';
import 'package:api_integ/screens/home_screen/controller/home_controller.dart';
import 'package:api_integ/widgets/info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/homeScreen';

  HomeScreen({super.key});

  final List<InfoModel> infoList = [
    InfoModel(
      image: 'assets/images/shahab.png',
      name: 'shahab',
      description: 'hello shahab',
      time: '1s',
      color: Colors.green,
      rating: "95",
    ),
    InfoModel(
      image: 'assets/images/shahab.png',
      name: 'ali',
      description: 'hello ali',
      time: '2s',
      color: Colors.blue,
      rating: "88",
    ),
    InfoModel(image:'assets/images/shahab.png' ,name:'zain' , description: 'hello zain', time: '3s', color: Colors.purpleAccent, rating: '90',),
  ];

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: (){
            NavigationHelper.navigateTo(Routes.uploadScreen);
          },
              child: Icon(Icons.drive_folder_upload,color: Colors.black,)),
        ],
        title: Text("API Screen"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: infoList.length,
        itemBuilder: (context, index) {
          final info = infoList[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InfoCardWidget(
              image: info.image,
              name: info.name,
              description: info.description,
              time: info.time,
              color: info.color,
              rating: info.rating,
            ),
          );
        },
      ),

    );
  }
}