// To parse this JSON data, do
//
//     final modelinventoryImquiryDetail = modelinventoryImquiryDetailFromJson(jsonString);

import 'dart:convert';

List<ModelinventoryImquiryDetail> modelinventoryImquiryDetailFromJson(String str) =>
    List<ModelinventoryImquiryDetail>.from(json.decode(str).map((x) => ModelinventoryImquiryDetail.fromJson(x)));

String modelinventoryImquiryDetailToJson(List<ModelinventoryImquiryDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelinventoryImquiryDetail {
  final String? issueCode;
  final DateTime? issueDate;
  final String? requestCode;
  final String? ptDesc;
  final String? lotSerial;
  final int? qtyIssue;
  final String? umName;

  ModelinventoryImquiryDetail({
    this.issueCode,
    this.issueDate,
    this.requestCode,
    this.ptDesc,
    this.lotSerial,
    this.qtyIssue,
    this.umName,
  });

  factory ModelinventoryImquiryDetail.fromJson(Map<String, dynamic> json) => ModelinventoryImquiryDetail(
        issueCode: json["issue_code"],
        issueDate: json["issue_date"] == null ? null : DateTime.parse(json["issue_date"]),
        requestCode: json["request_code"],
        ptDesc: json["pt_desc"],
        lotSerial: json["lot_serial"],
        qtyIssue: json["qty_issue"],
        umName: json["um_name"],
      );

  Map<String, dynamic> toJson() => {
        "issue_code": issueCode,
        "issue_date": issueDate?.toIso8601String(),
        "request_code": requestCode,
        "pt_desc": ptDesc,
        "lot_serial": lotSerial,
        "qty_issue": qtyIssue,
        "um_name": umName,
      };
}
