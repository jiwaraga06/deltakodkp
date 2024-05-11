import 'dart:convert';

List<ModelConsumableProductionUnitList> modelConsumableProductionUnitListFromJson(String str) =>
    List<ModelConsumableProductionUnitList>.from(json.decode(str).map((x) => ModelConsumableProductionUnitList.fromJson(x)));

class ModelConsumableProductionUnitList {
  final int? prodUnitId;
  final String? prodUnitName;

  ModelConsumableProductionUnitList({
    this.prodUnitId,
    this.prodUnitName,
  });

  factory ModelConsumableProductionUnitList.fromJson(Map<String, dynamic> json) => ModelConsumableProductionUnitList(
        prodUnitId: json["prod_unit_id"] ?? 0,
        prodUnitName: json["prod_unit_name"] ?? "",
      );
}
