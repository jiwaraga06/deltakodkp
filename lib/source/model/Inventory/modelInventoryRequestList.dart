// To parse this JSON data, do
//
//     final modelinventoryRequestList = modelinventoryRequestListFromJson(jsonString);

import 'dart:convert';

List<ModelinventoryRequestList> modelinventoryRequestListFromJson(String str) => List<ModelinventoryRequestList>.from(json.decode(str).map((x) => ModelinventoryRequestList.fromJson(x)));

String modelinventoryRequestListToJson(List<ModelinventoryRequestList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelinventoryRequestList {
    final String? requestOid;
    final String? requestCode;
    final int? enId;
    final int? branchId;
    final int? prodUnitId;
    final int? prodMachineId;

    ModelinventoryRequestList({
        this.requestOid,
        this.requestCode,
        this.enId,
        this.branchId,
        this.prodUnitId,
        this.prodMachineId,
    });

    factory ModelinventoryRequestList.fromJson(Map<String, dynamic> json) => ModelinventoryRequestList(
        requestOid: json["request_oid"],
        requestCode: json["request_code"],
        enId: json["en_id"],
        branchId: json["branch_id"],
        prodUnitId: json["prod_unit_id"],
        prodMachineId: json["prod_machine_id"],
    );

    Map<String, dynamic> toJson() => {
        "request_oid": requestOid,
        "request_code": requestCode,
        "en_id": enId,
        "branch_id": branchId,
        "prod_unit_id": prodUnitId,
        "prod_machine_id": prodMachineId,
    };
}
