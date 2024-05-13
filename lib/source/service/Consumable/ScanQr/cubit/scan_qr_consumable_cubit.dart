import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableScanQr.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'scan_qr_consumable_state.dart';

class ScanQrConsumableCubit extends Cubit<ScanQrConsumableState> {
  final RepositoryConsumable? repository;
  ScanQrConsumableCubit({this.repository}) : super(ScanQrConsumableInitial());

  void ScanQR(reqCode, locid, context) async {
    emit(ScanQrConsumableLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      // if (barcodeScanRes != '-1') {
        // 'PTKP/WM/19/08-00001'
        print(reqCode);
        print(locid);
        repository!.getScanQR(reqCode, "01-04-2024 126-017-002", "30001", context).then((value) {
          var json = value.body;
          var statusCode = value.statusCode;
          print("Scan QR: $json");
          print("Scan QR: $statusCode");
          if (statusCode == 401) {
          } else if (statusCode == 200) {
            emit(ScanQrConsumableLoaded(statusCode: statusCode, model: modelConsumableScanQrFromJson(json)));
          } else {
            MyDialog.dialogAlert(context, "Maaf terjadi kesalahan");
            emit(ScanQrConsumableLoaded(statusCode: statusCode, model: modelConsumableScanQrFromJson(jsonEncode([]))));
          }
        });
      // } else {
      //   EasyLoading.dismiss();
      // }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
