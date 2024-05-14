import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Inventory/modelInventoryRequestList.dart';
import 'package:deltakodkp/source/repository/repositoryInventory.dart';
import 'package:meta/meta.dart';

part 'inventory_req_list_state.dart';

class InventoryRequestListCubit extends Cubit<InventoryReqListState> {
  final RepositoryInventory? repository;
  InventoryRequestListCubit({this.repository}) : super(InventoryReqListInitial());
  var list = [];
  void inventoryReqList(context) {
    emit(InventoryReqListLoading());
    repository!.getInventoryReqList(context).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        var json = value.body;
        list = jsonDecode(json);
        emit(InventoryReqListLoaded(statusCode: statusCode, model: modelinventoryRequestListFromJson(json)));
      } else {
        emit(InventoryReqListLoaded(statusCode: statusCode, model: modelinventoryRequestListFromJson(jsonEncode([]))));
      }
    });
  }

  void inventoryReqListSearch(value, context) {
    emit(InventoryReqListLoading());
    // print(list);
    var hasil = list.where((e) => e['request_code'].toLowerCase().contains(value.toLowerCase())).toList();
    print('hasil: $hasil');
    if (value == '') {
      print('Kosong');
      emit(InventoryReqListLoaded(statusCode: 200, model: modelinventoryRequestListFromJson(jsonEncode(list))));
    } else {
      print('ada');
      emit(InventoryReqListLoaded(statusCode: 200, model: modelinventoryRequestListFromJson(jsonEncode(hasil))));
    }
  }
}
