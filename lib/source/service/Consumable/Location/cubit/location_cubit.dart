import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableLocationList.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'location_state.dart';

class LocationConsumableCubit extends Cubit<LocationConsumableState> {
  final RepositoryConsumable? repository;
  LocationConsumableCubit({this.repository}) : super(LocationConsumableInitial());

  void initial() {
    emit(LocationConsumableInitial());
  }

  void getLocation(id, branch, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString("username");
    emit(LocationConsumableLoading());
    repository!.getLocationList(id, branch, username, context).then((value) {
      var statusCode = value.statusCode;
      print("LOCATION: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
        var json = value.body;
        emit(LocationConsumableLoaded(statusCode: statusCode, model: modelConsumableLocationListFromJson(json)));
      } else {
        var json = jsonDecode(value.body);
        EasyLoading.dismiss();
        MyDialog.dialogAlert(context, json['message']);
        emit(LocationConsumableLoaded(statusCode: statusCode, model: modelConsumableLocationListFromJson(jsonEncode([]))));
      }
    });
  }
}
