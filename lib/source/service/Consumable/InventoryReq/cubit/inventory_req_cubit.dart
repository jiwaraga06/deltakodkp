import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableInventoryReq.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'inventory_req_state.dart';

class InventoryReqCubit extends Cubit<InventoryReqConsumableState> {
  final RepositoryConsumable? repository;
  InventoryReqCubit({this.repository}) : super(InventoryReqConsumableInitial());

  void inventoryReq(context) async {
    emit(InventoryReqConsumableloading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      // if (barcodeScanRes != '-1') {
        // 'PTKP/WM/19/08-00001'
        repository!.getInventoryReq("PTKP/IR/24/05-00588", context).then((value) {
          var json = value.body;
          var statusCode = value.statusCode;
          print("Inventory Req: $json");
          if (statusCode == 401) {
          } else if (statusCode == 200) {
            emit(InventoryReqConsumableloaded(statusCode: statusCode, model: modelConsumableInventoryReqFromJson(json)));
          } else {
            MyDialog.dialogAlert(context, "Maaf terjadi kesalahan");
            emit(InventoryReqConsumableloaded(statusCode: statusCode, model: modelConsumableInventoryReqFromJson(jsonEncode([]))));
          }
        });
      // } else {
      //   EasyLoading.dismiss();
      // }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void inventoryReqValue(code, context) {
    emit(InventoryReqConsumableloading());
    repository!.getInventoryReq(code, context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("Inventory Req: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
        emit(InventoryReqConsumableloaded(statusCode: statusCode, model: modelConsumableInventoryReqFromJson(json)));
      } else {
        MyDialog.dialogAlert(context, "Maaf terjadi kesalahan");
        emit(InventoryReqConsumableloaded(statusCode: statusCode, model: modelConsumableInventoryReqFromJson(jsonEncode([]))));
      }
    });
  }
}
