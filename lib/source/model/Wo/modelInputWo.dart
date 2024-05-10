import 'dart:convert';

class ModelInputWo {
  String? wodOid;
  int? ptId;
  String? ptDesc1;
  int? locId;
  String? locDesc;
  String? lotSerial;
  num? qtyIssue;

  ModelInputWo({
    required this.wodOid,
    required this.ptId,
    required this.ptDesc1,
    required this.locId,
    required this.locDesc,
    required this.lotSerial,
    required this.qtyIssue,
  });

  Map<String, dynamic> toJson() => {
        "wod_oid": wodOid,
        "pt_id": ptId,
        "pt_desc1": ptDesc1,
        "loc_id": locId,
        "loc_desc": locDesc,
        "lot_serial": lotSerial,
        "qty_issue": qtyIssue,
      };
  @override
  String toString() => "{wodOid: $wodOid, ptId: $ptId, ptDesc1: $ptDesc1, locId: $locId, locDesc: $locDesc, lotSerial: $lotSerial, qtyIssue: $qtyIssue}";
}
