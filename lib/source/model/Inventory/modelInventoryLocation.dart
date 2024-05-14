// To parse this JSON data, do
//
//     final modelinventoryLocation = modelinventoryLocationFromJson(jsonString);

import 'dart:convert';

List<ModelinventoryLocation> modelinventoryLocationFromJson(String str) => List<ModelinventoryLocation>.from(json.decode(str).map((x) => ModelinventoryLocation.fromJson(x)));

String modelinventoryLocationToJson(List<ModelinventoryLocation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelinventoryLocation {
    final int? locId;
    final String? locDesc;

    ModelinventoryLocation({
        this.locId,
        this.locDesc,
    });

    factory ModelinventoryLocation.fromJson(Map<String, dynamic> json) => ModelinventoryLocation(
        locId: json["loc_id"],
        locDesc: json["loc_desc"],
    );

    Map<String, dynamic> toJson() => {
        "loc_id": locId,
        "loc_desc": locDesc,
    };
}
