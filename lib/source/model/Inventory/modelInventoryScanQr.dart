// To parse this JSON data, do
//
//     final modelinventoryScamQr = modelinventoryScamQrFromJson(jsonString);

import 'dart:convert';

ModelinventoryScamQr modelinventoryScamQrFromJson(String str) => ModelinventoryScamQr.fromJson(json.decode(str));

String modelinventoryScamQrToJson(ModelinventoryScamQr data) => json.encode(data.toJson());

class ModelinventoryScamQr {
    final String? requestDetOid;
    final int? ptId;
    final String? ptDesc1;
    final int? plId;
    final int? umId;
    final String? umName;
    final String? lotSerial;
    final int? qtyOpen;
    final int? locId;
    final String? locDesc;
    final int? qtyIssue;

    ModelinventoryScamQr({
        this.requestDetOid,
        this.ptId,
        this.ptDesc1,
        this.plId,
        this.umId,
        this.umName,
        this.lotSerial,
        this.qtyOpen,
        this.locId,
        this.locDesc,
        this.qtyIssue,
    });

    factory ModelinventoryScamQr.fromJson(Map<String, dynamic> json) => ModelinventoryScamQr(
        requestDetOid: json["request_det_oid"],
        ptId: json["pt_id"],
        ptDesc1: json["pt_desc1"],
        plId: json["pl_id"],
        umId: json["um_id"],
        umName: json["um_name"],
        lotSerial: json["lot_serial"],
        qtyOpen: json["qty_open"],
        locId: json["loc_id"],
        locDesc: json["loc_desc"],
        qtyIssue: json["qty_issue"],
    );

    Map<String, dynamic> toJson() => {
        "request_det_oid": requestDetOid,
        "pt_id": ptId,
        "pt_desc1": ptDesc1,
        "pl_id": plId,
        "um_id": umId,
        "um_name": umName,
        "lot_serial": lotSerial,
        "qty_open": qtyOpen,
        "loc_id": locId,
        "loc_desc": locDesc,
        "qty_issue": qtyIssue,
    };
}
