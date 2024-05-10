
import 'dart:convert';

List<ModelConsumableInquiryDetail> modelConsumableInquiryDetailFromJson(String str) => List<ModelConsumableInquiryDetail>.from(json.decode(str).map((x) => ModelConsumableInquiryDetail.fromJson(x)));

class ModelConsumableInquiryDetail {
    final String? issueCode;
    final DateTime? issueDate;
    final String? requestCode;
    final String? ptDesc;
    final String? lotSerial;
    final num? qtyIssue;
    final String? umName;

    ModelConsumableInquiryDetail({
        this.issueCode,
        this.issueDate,
        this.requestCode,
        this.ptDesc,
        this.lotSerial,
        this.qtyIssue,
        this.umName,
    });

    factory ModelConsumableInquiryDetail.fromJson(Map<String, dynamic> json) => ModelConsumableInquiryDetail(
        issueCode: json["issue_code"] ?? "",
        issueDate: json["issue_date"] == null ? null : DateTime.parse(json["issue_date"]),
        requestCode: json["request_code"] ?? "",
        ptDesc: json["pt_desc"] ?? "",
        lotSerial: json["lot_serial"] ?? "",
        qtyIssue: json["qty_issue"] ?? 0,
        umName: json["um_name"] ?? "",
    );

}
