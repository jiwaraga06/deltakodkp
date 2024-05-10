import 'dart:convert';

ModelConsumableInventoryReq modelConsumableInventoryReqFromJson(String str) => ModelConsumableInventoryReq.fromJson(json.decode(str));

class ModelConsumableInventoryReq {
  final String? requestOid;
  final String? requestCode;
  final int? enId;
  final int? branchId;
  final int? prodUnitId;
  final int? prodMachineId;

  ModelConsumableInventoryReq({
    this.requestOid,
    this.requestCode,
    this.enId,
    this.branchId,
    this.prodUnitId,
    this.prodMachineId,
  });

  factory ModelConsumableInventoryReq.fromJson(Map<String, dynamic> json) => ModelConsumableInventoryReq(
        requestOid: json["request_oid"] ?? "",
        requestCode: json["request_code"] ?? "",
        enId: json["en_id"] ?? 0,
        branchId: json["branch_id"] ?? 0,
        prodUnitId: json["prod_unit_id"] ?? 0,
        prodMachineId: json["prod_machine_id"] ?? 0,
      );
}
