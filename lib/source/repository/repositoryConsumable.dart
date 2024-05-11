import 'package:deltakodkp/source/env/internetCheck.dart';
import 'package:deltakodkp/source/network/api.dart';
import 'package:deltakodkp/source/network/network.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';

class RepositoryConsumable {
  Future getInquiry(context, startdate, enddate) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getConsumableInquiry(startdate, enddate), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getInquiryDetail(issueCode, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getConsumableInquiryDetail(issueCode), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getInventoryReq(issueCode, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getConsumableInventoryReq(issueCode), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getInventoryReqList( context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getConsumableInventoryReqList(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getLocationList(id, branch, username, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getConsumableLocatiomList(id, branch, username), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getProductionUnitList(id, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getConsumableProductionUnitList(id), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getMachineList(id, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getConsumableMachineList(id), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getScanQR(code, lot, loc, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getConsumableScanQR(code, lot, loc), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
