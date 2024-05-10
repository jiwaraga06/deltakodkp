import 'dart:convert';

ModelScan modelScanFromJson(String str) => ModelScan.fromJson(json.decode(str));

class ModelScan {
  final String? wodOid;
  final num? ptId;
  final String? ptDesc1;
  final num? umId;
  final String? umName;
  final String? lotSerial;
  final num? qtyOpen;
  final num? qtyStock;
  final num? locId;
  final String? locDesc;
  final num? qtyIssue;

  ModelScan(
      {this.wodOid, this.ptId, this.ptDesc1, this.umId, this.umName, this.lotSerial, this.qtyOpen, this.qtyStock, this.locId, this.locDesc, this.qtyIssue});

  factory ModelScan.fromJson(Map<String, dynamic> json) => ModelScan(
        wodOid: json["wod_oid"] ?? "",
        ptId: json["pt_id"] ?? 0,
        ptDesc1: json["pt_desc1"] ?? "",
        umId: json["um_id"]?? 0,
        umName: json["um_name"] ?? "",
        lotSerial: json["lot_serial"] ?? "",
        qtyOpen: json["qty_open"] ?? 0,
        qtyStock: json["qty_stock"] ?? 0,
        locId: json["loc_id"]?? 0,
        locDesc: json["loc_desc"] ?? "",
        qtyIssue: json["qty_issue"] ?? 0,
      );
}
