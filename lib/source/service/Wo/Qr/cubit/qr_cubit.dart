import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Wo/modelQr.dart';
import 'package:deltakodkp/source/repository/repositoryWo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  final RepositoryWo? repository;
  QrCubit({this.repository}) : super(QrInitial());

  void qr(mr, locId, context) async {
    emit(QrLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        repository!.scanQrWo(mr, barcodeScanRes, locId, context).then((value) {
          var json = value.body;
          var statusCode = value.statusCode;
          print("Scan: $json");
          emit(QrLoaded(statusCode: statusCode, model: modelScanFromJson(json)));
        });
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
