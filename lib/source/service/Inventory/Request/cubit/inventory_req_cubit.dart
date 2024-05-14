import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Inventory/modelInventoryRequest.dart';
import 'package:deltakodkp/source/repository/repositoryInventory.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'inventory_req_state.dart';

class InventoryRequestCubit extends Cubit<InventoryReqState> {
  final RepositoryInventory? repository;
  InventoryRequestCubit({this.repository}) : super(InventoryReqInitial());

  void inventoryReq(context) async {
    emit(InventoryReqLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        // 'PTKP/WM/19/08-00001'
        repository!.getInventoryReq(barcodeScanRes, context).then((value) {
          var json = value.body;
          var statusCode = value.statusCode;
          print("Inventory Req: $json");
          if (statusCode == 401) {
          } else if (statusCode == 200) {
            emit(InventoryReqLoaded(statusCode: statusCode, model: modelinventoryRequestFromJson(json)));
          } else {
            var json = jsonDecode(value.body);
            EasyLoading.dismiss();
            MyDialog.dialogAlert(context, json['message']);
            emit(InventoryReqLoaded(statusCode: statusCode, model: modelinventoryRequestFromJson(jsonEncode([]))));
          }
        });
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void inventoryReqValue(value, context) async {
    emit(InventoryReqLoading());
    repository!.getInventoryReq(value, context).then((value) {
      var statusCode = value.statusCode;
      print("Inventory Req: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
      var json = value.body;
        emit(InventoryReqLoaded(statusCode: statusCode, model: modelinventoryRequestFromJson(json)));
      } else {
        var json = jsonDecode(value.body);
        EasyLoading.dismiss();
        MyDialog.dialogAlert(context, json['message']);
        emit(InventoryReqLoaded(statusCode: statusCode, model: modelinventoryRequestFromJson(jsonEncode([]))));
      }
    });
  }
}
