class ItemInfoModel {
  final bool success;
  final String message;
  final Data data;

  ItemInfoModel({
    required this.success,
    required this.message,
    required this.data,
  });

}

class Data {
  final String id;
  final String itemName;
  final String itemDescription;
  final int itemPoints;
  final String itemImage;
  final DateTime createdTime;

  Data({
    required this.id,
    required this.itemName,
    required this.itemDescription,
    required this.itemPoints,
    required this.itemImage,
    required this.createdTime,
  });

}
