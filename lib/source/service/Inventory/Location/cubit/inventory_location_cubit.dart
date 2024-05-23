import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Inventory/modelInventoryLocation.dart';
import 'package:deltakodkp/source/repository/repositoryInventory.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'inventory_location_state.dart';

class InventoryLocationCubit extends Cubit<InventoryLocationState> {
  final RepositoryInventory? repository;
  InventoryLocationCubit({this.repository}) : super(InventoryLocationInitial());

  void initial() {
    emit(InventoryLocationInitial());
  }

  void getLocation(enid, branchId, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString("username");
    emit(InventoryLocationloading());
    repository!.getLocationList(enid, branchId, username, context).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        var json = value.body;
        print("Location: $json");
        emit(InventoryLocationloaded(statusCode: statusCode, model: modelinventoryLocationFromJson(json)));
      } else {
        var json = jsonDecode(value.body);
        print("Location: $json");
        emit(InventoryLocationloaded(statusCode: statusCode, model: modelinventoryLocationFromJson(jsonEncode([]))));
      }
    });
  }
}
