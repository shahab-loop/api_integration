import 'package:api_integ/core/models/item_info_model.dart';
import 'package:api_integ/services/api_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiService apiService = ApiService();

  // Observable list of data from the API
  RxList<Datum> infoList = <Datum>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }

  Future<void> fetchItems() async {
    try {
      isLoading.value = true;
      final response = await apiService.getItems();

      if (response !.statusCode == 200) {
        final itemModel = itemInfoModelFromJson(response.body);
        infoList.assignAll(itemModel.data);
      } else {
        Get.snackbar("Error", "Failed to load items");
      }
    } catch (e) {
      isLoading.value = false;
      print("Fetch Items Error: $e");
      Get.snackbar("Error", "Something went wrong while fetching items");
    }
  }
}
