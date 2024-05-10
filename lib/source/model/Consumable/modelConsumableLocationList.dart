import 'dart:convert';

List<ModelConsumableLocationList> modelConsumableLocationListFromJson(String str) =>
    List<ModelConsumableLocationList>.from(json.decode(str).map((x) => ModelConsumableLocationList.fromJson(x)));

class ModelConsumableLocationList {
  final int? locId;
  final String? locDesc;

  ModelConsumableLocationList({
    this.locId,
    this.locDesc,
  });

  factory ModelConsumableLocationList.fromJson(Map<String, dynamic> json) => ModelConsumableLocationList(
        locId: json["loc_id"] ?? 0,
        locDesc: json["loc_desc"] ?? "",
      );
}
