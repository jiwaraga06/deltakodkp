import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableLocationList.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final RepositoryConsumable? repository;
  LocationCubit({this.repository}) : super(LocationInitial());

  void getLocation(id, branch, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString("username");
    emit(LocationLoading());
    repository!.getLocationList(id, branch, username, context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("LOCATION: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
        emit(LocationLoaded(statusCode: statusCode, model: modelConsumableLocationListFromJson(json)));
      } else {
        emit(LocationLoaded(statusCode: statusCode, model: modelConsumableLocationListFromJson(jsonEncode([]))));
      }
    });
  }
}
