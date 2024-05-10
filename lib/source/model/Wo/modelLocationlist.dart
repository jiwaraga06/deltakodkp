import 'dart:convert';

List<ModelLocationList> modelLocationListFromJson(String str) => List<ModelLocationList>.from(json.decode(str).map((x) => ModelLocationList.fromJson(x)));

class ModelLocationList {
  final num? locId;
  final String? locDesc;

  ModelLocationList({this.locId, this.locDesc});

  factory ModelLocationList.fromJson(Map<String, dynamic> json) => ModelLocationList(
        locId: json["loc_id"] ?? 0,
        locDesc: json["loc_desc"] ?? "",
      );
}
