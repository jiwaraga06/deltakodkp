import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Wo/modelMaterialReq.dart';
import 'package:deltakodkp/source/repository/repositoryWo.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'material_request_state.dart';

class MaterialRequestCubit extends Cubit<MaterialRequestState> {
  final RepositoryWo? repository;
  MaterialRequestCubit({this.repository}) : super(MaterialRequestInitial());

  void getMaterialReq(context) async {
    emit(MaterialRequestLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        // 'PTKP/WM/19/08-00001'
        repository!.getMaterialRequest(barcodeScanRes, context).then((value) {
          var statusCode = value.statusCode;
          print("Material Req: $json");
          if (statusCode == 401) {
          } else if (statusCode == 200) {
            var json = value.body;
            emit(MaterialRequestLoaded(statusCode: statusCode, model: modelMaterialReqFromJson(json)));
          } else {
            var json = jsonDecode(value.body);
            MyDialog.dialogAlert(context, json['message']);
            emit(MaterialRequestLoaded(statusCode: statusCode, model: modelMaterialReqFromJson(jsonEncode([]))));
          }
        });
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void getMaterialReqValue(value, context) async {
    emit(MaterialRequestLoading());
    repository!.getMaterialRequest(value, context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("Material Req: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
        emit(MaterialRequestLoaded(statusCode: statusCode, model: modelMaterialReqFromJson(json)));
      } else {
        MyDialog.dialogAlert(context, "Maaf terjadi kesalahan");
        emit(MaterialRequestLoaded(statusCode: statusCode, model: modelMaterialReqFromJson(jsonEncode([]))));
      }
    });
  }
}
