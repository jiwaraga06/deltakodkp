import 'dart:convert';

List<ModelConsumableInventoryList> modelConsumableInventoryListFromJson(String str) =>
    List<ModelConsumableInventoryList>.from(json.decode(str).map((x) => ModelConsumableInventoryList.fromJson(x)));

class ModelConsumableInventoryList {
  final String? requestOid;
  final String? requestCode;
  final int? enId;
  final int? branchId;
  final int? prodUnitId;
  final int? prodMachineId;

  ModelConsumableInventoryList({
    this.requestOid,
    this.requestCode,
    this.enId,
    this.branchId,
    this.prodUnitId,
    this.prodMachineId,
  });

  factory ModelConsumableInventoryList.fromJson(Map<String, dynamic> json) => ModelConsumableInventoryList(
        requestOid: json["request_oid"] ?? "",
        requestCode: json["request_code"] ?? "",
        enId: json["en_id"] ?? 0,
        branchId: json["branch_id"] ?? 0,
        prodUnitId: json["prod_unit_id"] ?? 0,
        prodMachineId: json["prod_machine_id"] ?? 0,
      );
}
