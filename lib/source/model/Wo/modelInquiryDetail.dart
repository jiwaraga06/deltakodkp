import 'dart:convert';

List<ModelInquiryDetail> modelInquiryDetailFromJson(String str) => List<ModelInquiryDetail>.from(json.decode(str).map((x) => ModelInquiryDetail.fromJson(x)));

class ModelInquiryDetail {
  final String? issueCode;
  final String? woCode;
  final String? ptDesc;
  final String? lotSerial;
  final num? qtyIssue;
  final String? umName;

  ModelInquiryDetail({this.issueCode, this.woCode, this.ptDesc, this.lotSerial, this.qtyIssue, this.umName});

  factory ModelInquiryDetail.fromJson(Map<String, dynamic> json) => ModelInquiryDetail(
        issueCode: json["issue_code"] ?? "",
        woCode: json["wo_code"] ?? "",
        ptDesc: json["pt_desc"] ?? "",
        lotSerial: json["lot_serial"] ?? "",
        qtyIssue: json["qty_issue"] ?? "",
        umName: json["um_name"] ?? "",
      );
}
