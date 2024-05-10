import 'dart:convert';

List<ModelInquiry> modelInquiryFromJson(String str) => List<ModelInquiry>.from(json.decode(str).map((x) => ModelInquiry.fromJson(x)));

class ModelInquiry {
  final String? issueCode;
  final DateTime? issueDate;
  final String? woCode;
  final String? requestCode;

  ModelInquiry({this.issueCode, this.issueDate, this.woCode, this.requestCode});

  factory ModelInquiry.fromJson(Map<String, dynamic> json) => ModelInquiry(
        issueCode: json["issue_code"] ?? "",
        issueDate: DateTime.parse(json["issue_date"]) ,
        woCode: json["wo_code"] ?? "",
        requestCode: json["request_code"] ?? "",
      );
}
