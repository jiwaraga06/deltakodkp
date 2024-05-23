import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableLocationList.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableProductionUnitList.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'production_state.dart';

class ProductionCubit extends Cubit<ProductionState> {
  final RepositoryConsumable? repository;
  ProductionCubit({this.repository}) : super(ProductionInitial());

  void initial() {
    emit(ProductionInitial());
  }

  void production(id, context) {
    emit(ProductionLoading());
    repository!.getProductionUnitList(id, context).then((value) {
      var statusCode = value.statusCode;
      print("PRODUCTION : $json");
      if (statusCode == 200) {
        var json = value.body;
        emit(ProductionLoaded(statusCode: statusCode, model: modelConsumableProductionUnitListFromJson(json)));
      } else {
        var json = jsonDecode(value.body);
        EasyLoading.dismiss();
        MyDialog.dialogAlert(context, json['message']);
        emit(ProductionLoaded(statusCode: statusCode, model: modelConsumableProductionUnitListFromJson(jsonEncode([]))));
      }
    });
  }
}
