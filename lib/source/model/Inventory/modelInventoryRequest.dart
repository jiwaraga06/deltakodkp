// To parse this JSON data, do
//
//     final modelinventoryRequest = modelinventoryRequestFromJson(jsonString);

import 'dart:convert';

ModelinventoryRequest modelinventoryRequestFromJson(String str) => ModelinventoryRequest.fromJson(json.decode(str));

String modelinventoryRequestToJson(ModelinventoryRequest data) => json.encode(data.toJson());

class ModelinventoryRequest {
    final String? requestOid;
    final String? requestCode;
    final int? enId;
    final int? branchId;
    final int? prodUnitId;
    final int? prodMachineId;

    ModelinventoryRequest({
        this.requestOid,
        this.requestCode,
        this.enId,
        this.branchId,
        this.prodUnitId,
        this.prodMachineId,
    });

    factory ModelinventoryRequest.fromJson(Map<String, dynamic> json) => ModelinventoryRequest(
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
