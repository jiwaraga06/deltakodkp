import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/env/env.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'insert_consumable_state.dart';

class InsertConsumableCubit extends Cubit<InsertConsumableState> {
  final RepositoryConsumable? repository;
  InsertConsumableCubit({this.repository}) : super(InsertConsumableInitial());

  void insertConsumbale(date, enid, branchId, reqOid, reqCode, prodId, machineId, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString("username");
    var body = {
      "issue_date": "$date",
      "add_by": "$username",
      "en_id": "$enid",
      "branch_id": "$branchId",
      "request_oid": "$reqOid",
      "request_code": "$reqCode",
      "prod_unit_id": "$prodId",
      "prod_machine_id": "$machineId",
      "consumableIssueDetail": inputconsumable
    };
    print(body);
    emit(InsertConsumableloading());
    repository!.insertConsumable(jsonEncode(body), context).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("Result insert: $json");
      print(statusCode);
      emit(InsertConsumableloaded(statusCode: statusCode, json: json));
    });
  }
}
