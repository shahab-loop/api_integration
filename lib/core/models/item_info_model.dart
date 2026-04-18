import 'dart:convert';

ItemInfoModel itemInfoModelFromJson(String str) => ItemInfoModel.fromJson(json.decode(str));

String itemInfoModelToJson(ItemInfoModel data) => json.encode(data.toJson());

class ItemInfoModel {
  final bool success;
  final String message;
  final List<Datum> data;

  ItemInfoModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ItemInfoModel.fromJson(Map<String, dynamic> json) => ItemInfoModel(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final String id;
  final String itemName;
  final String itemDescription;
  final int itemPoints;
  final String itemImage;
  final DateTime createdTime;

  Datum({
    required this.id,
    required this.itemName,
    required this.itemDescription,
    required this.itemPoints,
    required this.itemImage,
    required this.createdTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"] ?? "",
    itemName: json["item_name"] ?? "",
    itemDescription: json["item_description"] ?? "",
    itemPoints: json["item_points"] ?? 0,
    itemImage: json["item_image"] ?? "",
    createdTime: json["createdTime"] != null ? DateTime.parse(json["createdTime"]) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "item_name": itemName,
    "item_description": itemDescription,
    "item_points": itemPoints,
    "item_image": itemImage,
    "createdTime": createdTime.toIso8601String(),
  };
}
