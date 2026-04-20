import 'package:api_integ/core/models/item_info_model.dart';
import 'package:api_integ/services/api_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiService apiService = ApiService();


  RxList<Datum> infoList = <Datum>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }
  String getTimeAgo(String dateTimeString) {
    final time = DateTime.parse(dateTimeString).toLocal();
    final diff = DateTime.now().difference(time);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo ago';
    return '${(diff.inDays / 365).floor()}y ago';
  }
  Future<void> fetchItems() async {
    try {
      isLoading.value = true;
      final response = await apiService.getItems();

      if (response !.statusCode == 200) {
     isLoading.value = false;
        final itemModel = itemInfoModelFromJson(response.body);
        infoList.assignAll(itemModel.data);
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Failed to load items");
      }
    } catch (e) {
      isLoading.value = false;
      print("Fetch Items Error: $e");
      Get.snackbar("Error", "Something went wrong while fetching items");
    }
  }
}
