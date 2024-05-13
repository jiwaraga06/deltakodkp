class ModelinputConsumable {
  String? requestDetOid;
  int? ptId;
  String? ptDesc1;
  int? plId;
  int? umId;
  int? locId;
  String? locDesc;
  String? lotSerial;
  num? qtyIssue;

  ModelinputConsumable({this.requestDetOid, this.ptId, this.ptDesc1, this.plId, this.umId, this.locId, this.locDesc, this.lotSerial, this.qtyIssue});

  factory ModelinputConsumable.fromJson(Map<String, dynamic> json) => ModelinputConsumable(
      requestDetOid: json["request_det_oid"],
      ptId: json["pt_id"],
      ptDesc1: json["pt_desc1"],
      plId: json["pl_id"],
      umId: json["um_id"],
      locId: json["loc_id"],
      locDesc: json["loc_desc"],
      lotSerial: json["lot_serial"],
      qtyIssue: json["qty_issue"]);

  Map<String, dynamic> toJson() => {
        "request_det_oid": requestDetOid,
        "pt_id": ptId,
        "pt_desc1": ptDesc1,
        "pl_id": plId,
        "um_id": umId,
        "loc_id": locId,
        "loc_desc": locDesc,
        "lot_serial": lotSerial,
        "qty_issue": qtyIssue
      };
  @override
  String toString() =>
      "{ request_det_oid $requestDetOid, pt_id: $ptId, pt_desc1: $ptDesc1, pl_id: $plId, um_id: $umId, loc_id: $locId, loc_desc: $locDesc, lot_serial: $lotSerial, qty_issue: $qtyIssue}";
}
