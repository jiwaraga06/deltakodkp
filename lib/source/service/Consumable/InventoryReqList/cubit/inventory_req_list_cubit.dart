import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableInventoryList.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:meta/meta.dart';

part 'inventory_req_list_state.dart';

class InventoryReqListCubit extends Cubit<InventoryReqConsumableListState> {
  final RepositoryConsumable? repository;
  InventoryReqListCubit({this.repository}) : super(InventoryReqConsumableListInitial());
  var list = [];
  void inventoryReqList(context) {
    emit(InventoryReqConsumableListLoading());
    repository!.getInventoryReqList(context).then((value) {
      var json = value.body;
      list = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("Inventory Req List: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
        emit(InventoryReqConsumableListLoaded(statusCode: statusCode, model: modelConsumableInventoryListFromJson(json)));
      } else {
        MyDialog.dialogAlert(context, "Maaf terjadi kesalahan");
        emit(InventoryReqConsumableListLoaded(statusCode: statusCode, model: modelConsumableInventoryListFromJson(jsonEncode([]))));
      }
    });
  }

  void searchData(value) {
    emit(InventoryReqConsumableListLoading());


    // print(list);
    var hasil = list.where((e) => e['request_code'].toLowerCase().contains(value.toLowerCase())).toList();
    print('hasil: $hasil');
    if (value == '') {
      print('Kosong');
      emit(InventoryReqConsumableListLoaded(statusCode: 200, model: modelConsumableInventoryListFromJson(jsonEncode(list))));
    } else {
      print('ada');
      emit(InventoryReqConsumableListLoaded(statusCode: 200, model: modelConsumableInventoryListFromJson(jsonEncode(hasil))));
    }
  }
}
