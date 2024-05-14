import 'package:deltakodkp/source/env/internetCheck.dart';
import 'package:deltakodkp/source/network/api.dart';
import 'package:deltakodkp/source/network/network.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';

class RepositoryInventory {
  Future getInquiry(context, startdate, enddate) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getInquiryInventory(startdate, enddate), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getInquiryDetail(issueCode, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getInquiryInventoryDetail(issueCode), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getInventoryReq(issueCode, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getInventoryReq(issueCode), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getInventoryReqList(context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getInventoryReqList(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getLocationList(id, branch, username, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getInventoryLocation(id, branch, username), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getScanQR(code, lot, loc, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.scanQrInventory(code, lot, loc), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getScanQRNonIr(lot, loc, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.scanQrNonIr(lot, loc), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future insertInventory(body, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.insertInventory(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
