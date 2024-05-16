import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Inventory/modelInventoryScanQr.dart';
import 'package:deltakodkp/source/repository/repositoryInventory.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'scan_qr_state.dart';

class ScanQrCubit extends Cubit<ScanQrState> {
  final RepositoryInventory? repository;
  ScanQrCubit({this.repository}) : super(ScanQrInitial());

  void scanQr(reqCode, locId, context) async {
    emit(ScanQrLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        // 'PTKP/WM/19/08-00001'
        repository!.getScanQR(reqCode, barcodeScanRes, locId, context).then((value) {
          var statusCode = value.statusCode;
          if (statusCode == 200) {
            var json = value.body;
            emit(ScanQrLoaded(statusCode: statusCode, model: modelinventoryScamQrFromJson(json)));
          } else {
            var json = jsonDecode(value.body);
            print("\n\n json: $json");
            EasyLoading.dismiss();
            if (json['message'] != null) {
              MyDialog.dialogAlert(context, json['message']);
            } else {
              MyDialog.dialogAlert(context, json['errors']);
              emit(ScanQrLoaded(statusCode: statusCode, model: modelinventoryScamQrFromJson(jsonEncode({}))));
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
