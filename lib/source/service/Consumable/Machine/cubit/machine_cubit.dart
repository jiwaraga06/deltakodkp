import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableMachineList.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'machine_state.dart';

class MachineCubit extends Cubit<MachineState> {
  final RepositoryConsumable? repository;
  MachineCubit({this.repository}) : super(MachineInitial());

  void initial() {
    emit(MachineInitial());
  }

  void machine(id, context) {
    emit(MachineLoading());
    repository!.getMachineList(id, context).then((value) {
      var statusCode = value.statusCode;
      print("MACHINE: $json");
      if (statusCode == 200) {
        var json = value.body;
        emit(MachineLoaded(statusCode: statusCode, model: modelConsumableMachineListFromJson(json)));
      } else {
        var json = jsonDecode(value.body);
        EasyLoading.dismiss();
        MyDialog.dialogAlert(context, json['message']);
        emit(MachineLoaded(statusCode: statusCode, model: modelConsumableMachineListFromJson(jsonEncode([]))));
      }
    });
  }
}
