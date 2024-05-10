import 'package:deltakodkp/source/env/internetCheck.dart';
import 'package:deltakodkp/source/network/api.dart';
import 'package:deltakodkp/source/network/network.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';

class RepositoryWo {
  Future getInquiry(context, startdate, enddate) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getInquiry(startdate, enddate), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getInquiryDetail(issueCode, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getInquiryDetail(issueCode), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getMaterialRequestList(context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getMaterialRequestList(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getMaterialRequest(materialReq, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getMaterialRequest(materialReq), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getLocationList(enId, branchId, username, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.getLocationList(enId, branchId, username), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future scanQrWo(mr, lot, loc, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.scanQrWo(mr, lot, loc), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future insertWo(body, context) async {
    if (await internetChecker()) {
      var json = await network(url: Api.insertWo(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
