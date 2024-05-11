import 'dart:convert';

ModelConsumableScanQr modelConsumableScanQrFromJson(String str) => ModelConsumableScanQr.fromJson(json.decode(str));

class ModelConsumableScanQr {
  final String? requestDetOid;
  final num? ptId;
  final String? ptDesc1;
  final num? plId;
  final num? umId;
  final String? umName;
  final String? lotSerial;
  final num? qtyOpen;
  final num? locId;
  final String? locDesc;
  final num? qtyIssue;

  ModelConsumableScanQr({
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

  factory ModelConsumableScanQr.fromJson(Map<String, dynamic> json) => ModelConsumableScanQr(
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
}
