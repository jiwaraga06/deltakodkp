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

  static insertConsumable() {
    return "$host/api/ConsumableIssue/Insert";
  }

  // inventory
  static getInquiryInventory(startdate, enddate) {
    return "$host/api/InventoryIssue/GetInquiry?start_date=$startdate&end_date=$enddate";
  }

  static getInquiryInventoryDetail(issueCode) {
    return "$host/api/InventoryIssue/GetInquiryDetail?issue_code=$issueCode";
  }

  static getInventoryReq(reqCode) {
    return "$host/api/InventoryIssue/GetInventoryRequest?inventory_request_code=$reqCode";
  }

  static getInventoryReqList() {
    return "$host/api/InventoryIssue/GetInventoryRequestList";
  }

  static getInventoryLocation(enid, branchid, username) {
    return "$host/api/InventoryIssue/GetLocationList?en_id=$enid&branch_id=$branchid&user_name=$username";
  }

  static scanQrInventory(reqCode, lotserial, locid) {
    return "$host/api/InventoryIssue/ScanQR?request_code=$reqCode&lot_serial_no=$lotserial&loc_id=$locid";
  }

  static scanQrNonIr(lotserial, locid) {
    return "$host/api/InventoryIssue/ScanQR?lot_serial_no=$lotserial&loc_id=$locid";
  }

  static insertInventory() {
    return "$host/api/InventoryIssue/Insert";
  }
}
