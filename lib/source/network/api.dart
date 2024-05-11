import 'package:deltakodkp/source/env/env.dart';

class Api {
  static login() {
    return "$host/api/Login";
  }

  // WO
  static getInquiry(startdate, enddate) {
    return "$host/api/WOIssue/GetInquiry?start_date=$startdate&end_date=$enddate";
  }

  static getInquiryDetail(issueCode) {
    return "$host/api/WOIssue/GetInquiryDetail?issue_code=$issueCode";
  }

  static getMaterialRequestList() {
    return "$host/api/WOIssue/GetMaterialRequestList";
  }

  static getMaterialRequest(materialReq) {
    return "$host/api/WOIssue/GetMaterialRequest?material_request_code=$materialReq";
  }

  static getLocationList(enId, branchId, username) {
    return "$host/api/WOIssue/GetLocationList?en_id=$enId&branch_id=$branchId&user_name=$username";
  }

  static scanQrWo(mr, lot, loc) {
    return "$host/api/WOIssue/ScanQR?material_request_code=$mr&lot_serial_no=$lot&loc_id=$loc";
  }

  static insertWo() {
    return "$host/api/WOIssue/Insert";
  }

  // CONSUMABLE
  static getConsumableInquiry(startdate, enddate) {
    return "$host/api/ConsumableIssue/GetInquiry?start_date=$startdate&end_date=$enddate";
  }

  static getConsumableInquiryDetail(issueCode) {
    return "$host/api/ConsumableIssue/GetInquiryDetail?issue_code=$issueCode";
  }

  static getConsumableInventoryReq(code) {
    return "$host/api/ConsumableIssue/GetInventoryRequest?inventory_request_code=$code";
  }

  static getConsumableInventoryReqList() {
    return "$host/api/ConsumableIssue/GetInventoryRequestList";
  }

  static getConsumableLocatiomList(id, branch, username) {
    return "$host/api/ConsumableIssue/GetLocationList?en_id=$id&branch_id=$branch&user_name=$username";
  }

  static getConsumableProductionUnitList(id) {
    return "$host/api/ConsumableIssue/GetProductionUnitList?en_id=$id";
  }

  static getConsumableMachineList(id) {
    return "$host/api/ConsumableIssue/GetProductionMachineList?en_id=$id";
  }

  static getConsumableScanQR(code, lot, loc) {
    return "$host/api/ConsumableIssue/ScanQR?request_code=$code&lot_serial_no=$lot&loc_id=$loc";
  }
}
