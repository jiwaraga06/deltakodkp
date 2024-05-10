import 'dart:convert';

List<ModelConsumableInquiry> modelConsumableInquiryFromJson(String str) =>
    List<ModelConsumableInquiry>.from(json.decode(str).map((x) => ModelConsumableInquiry.fromJson(x)));

class ModelConsumableInquiry {
  final String? issueCode;
  final DateTime? issueDate;
  final String? requestCode;

  ModelConsumableInquiry({
    this.issueCode,
    this.issueDate,
    this.requestCode,
  });

  factory ModelConsumableInquiry.fromJson(Map<String, dynamic> json) => ModelConsumableInquiry(
        issueCode: json["issue_code"] ?? "",
        issueDate: json["issue_date"] == null ? null : DateTime.parse(json["issue_date"]),
        requestCode: json["request_code"] ?? "",
      );
}
