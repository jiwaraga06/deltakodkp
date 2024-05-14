class Modelinputinventory {
  final String? requestDetOid;
  final int? ptId;
  final String? ptDesc1;
  final int? plId;
  final int? umId;
  final int? locId;
  final String? locDesc;
  final String? lotSerial;
  num? qtyIssue;

  Modelinputinventory({this.requestDetOid, this.ptId, this.ptDesc1, this.plId, this.umId, this.locId, this.locDesc, this.lotSerial, this.qtyIssue});

  Map<String, dynamic> toJson() => {
        "request_det_oid": requestDetOid,
        "pt_id": ptId,
        "pt_desc1": ptDesc1,
        "pl_id": plId,
        "um_id": umId,
        "loc_id": locId,
        "loc_desc": locDesc,
        "lot_serial": lotSerial,
        "qty_issue": qtyIssue,
      };
  @override
  String toString() =>
      "{requestDetOid: $requestDetOid,ptId: $ptId, ptDesc1: $ptDesc1, plId: $plId, umId: $umId, locId: $locId, locDesc: $locDesc, lotSerial: $lotSerial, qtyIssue: $qtyIssue}";
}
