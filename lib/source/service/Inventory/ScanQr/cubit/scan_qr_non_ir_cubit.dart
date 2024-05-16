import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Inventory/modelInventoryScanQrNonIr.dart';
import 'package:deltakodkp/source/repository/repositoryInventory.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'scan_qr_non_ir_state.dart';

class ScanQrNonIrCubit extends Cubit<ScanQrNonIrState> {
  final RepositoryInventory? repository;
  ScanQrNonIrCubit({this.repository}) : super(ScanQrNonIrInitial());

  void scanQrNonIr(locId, context) async {
    emit(ScanQrNonIrLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        // 'PTKP/WM/19/08-00001'
        repository!.getScanQRNonIr(barcodeScanRes, locId, context).then((value) {
          var statusCode = value.statusCode;
          if (statusCode == 200) {
            var json = value.body;
            emit(ScanQrNonIrLoaded(statusCode: statusCode, model: modelinventoryScamQrNonIrFromJson(json)));
          } else {
            var json = jsonDecode(value.body);
            print("json: $json");
            EasyLoading.dismiss();
            if (json['message'] != null) {
              MyDialog.dialogAlert(context, json['message']);
              emit(ScanQrNonIrLoaded(statusCode: statusCode, model: modelinventoryScamQrNonIrFromJson(jsonEncode({}))));
            } else {
              MyDialog.dialogAlert(context, json['errors']);
              emit(ScanQrNonIrLoaded(statusCode: statusCode, model: modelinventoryScamQrNonIrFromJson(jsonEncode({}))));
            }
      
          }
        });
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
