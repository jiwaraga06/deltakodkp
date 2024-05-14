// To parse this JSON data, do
//
//     final modelinventoryImquiry = modelinventoryImquiryFromJson(jsonString);

import 'dart:convert';

List<ModelinventoryImquiry> modelinventoryImquiryFromJson(String str) =>
    List<ModelinventoryImquiry>.from(json.decode(str).map((x) => ModelinventoryImquiry.fromJson(x)));

String modelinventoryImquiryToJson(List<ModelinventoryImquiry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelinventoryImquiry {
  final String? issueCode;
  final DateTime? issueDate;
  final dynamic requestCode;

  ModelinventoryImquiry({
    this.issueCode,
    this.issueDate,
    this.requestCode,
  });

  factory ModelinventoryImquiry.fromJson(Map<String, dynamic> json) => ModelinventoryImquiry(
        issueCode: json["issue_code"],
        issueDate: json["issue_date"] == null ? null : DateTime.parse(json["issue_date"]),
        requestCode: json["request_code"],
      );

  Map<String, dynamic> toJson() => {
        "issue_code": issueCode,
        "issue_date": issueDate?.toIso8601String(),
        "request_code": requestCode,
      };
}
