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
}
