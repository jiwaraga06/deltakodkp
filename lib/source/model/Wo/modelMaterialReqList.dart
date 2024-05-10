import 'dart:convert';

List<ModelMaterialList> modelMaterialListFromJson(String str) => List<ModelMaterialList>.from(json.decode(str).map((x) => ModelMaterialList.fromJson(x)));

class ModelMaterialList {
  final String? woiOid;
  final String? woiCode;
  final num? enId;
  final num? branchId;
  final num? ccId;
  final num? woId;
  final String? woOid;
  final String? woCode;

  ModelMaterialList({this.woiOid, this.woiCode, this.enId, this.branchId, this.ccId, this.woId, this.woOid, this.woCode});

  factory ModelMaterialList.fromJson(Map<String, dynamic> json) => ModelMaterialList(
        woiOid: json["woi_oid"] ?? "",
        woiCode: json["woi_code"] ?? "",
        enId: json["en_id"] ?? 0,
        branchId: json["branch_id"] ?? 0,
        ccId: json["cc_id"] ?? 0,
        woId: json["wo_id"] ?? 0,
        woOid: json["wo_oid"] ?? "",
        woCode: json["wo_code"] ?? "",
      );
}
