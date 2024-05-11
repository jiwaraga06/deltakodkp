import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableInventoryList.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:meta/meta.dart';

part 'inventory_req_list_state.dart';

class InventoryReqListCubit extends Cubit<InventoryReqListState> {
  final RepositoryConsumable? repository;
  InventoryReqListCubit({this.repository}) : super(InventoryReqListInitial());

  void inventoryReqList(context) {
    emit(InventoryReqListLoading());
    repository!.getInventoryReqList(context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("Inventory Req List: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
        emit(InventoryReqListLoaded(statusCode: statusCode, model: modelConsumableInventoryListFromJson(json)));
      } else {
        MyDialog.dialogAlert(context, "Maaf terjadi kesalahan");
        emit(InventoryReqListLoaded(statusCode: statusCode, model: modelConsumableInventoryListFromJson(jsonEncode([]))));
      }
    });
  }
}
