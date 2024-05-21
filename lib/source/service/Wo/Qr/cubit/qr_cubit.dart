import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Wo/modelQr.dart';
import 'package:deltakodkp/source/repository/repositoryWo.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  final RepositoryWo? repository;
  QrCubit({this.repository}) : super(QrInitial());

  void qr(mr, lot, locId, context) async {
    emit(QrLoading());
    // String? barcodeScanRes;
    // try {
    //   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
    //   print('Result Scan:  $barcodeScanRes');
    //   if (barcodeScanRes != '-1') {
    repository!.scanQrWo(mr, lot, locId, context).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        var json = value.body;
        print("Scan: $json");
        emit(QrLoaded(statusCode: statusCode, model: modelScanFromJson(json)));
      } else {
        EasyLoading.dismiss();
        var json = jsonDecode(value.body);
        if (json['message'] != null) {

        MyDialog.dialogAlert(context, json['message']);
        } else {
        MyDialog.dialogAlert(context, json['errors']);

        }
        emit(QrLoaded(statusCode: statusCode, model: modelScanFromJson(jsonEncode({}))));
      }
    });
    //     } else {
    //       EasyLoading.dismiss();
    //     }
    //   } on PlatformException {
    //     barcodeScanRes = 'Failed to get platform version.';
    //   }
  }
}
