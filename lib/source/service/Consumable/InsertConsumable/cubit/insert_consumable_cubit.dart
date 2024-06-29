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

  void insertConsumbale(date, enid, branchId, reqOid, reqCode, prodId, machineId, ket, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString("username");
    var body = {
      "issue_date": "$date",
      "en_id": "$enid",
      "branch_id": "$branchId",
      "request_oid": "$reqOid",
      "request_code": "$reqCode",
      "prod_unit_id": "$prodId",
      "prod_machine_id": "$machineId",
      "add_by": "$username",
      "issue_remarks": "$ket",
      "consumableIssueDetail": inputconsumable
    };
    print(body);
    emit(InsertConsumableloading());
    repository!.insertConsumable(jsonEncode(body), context).then((value) {
      var statusCode = value.statusCode;
      print(statusCode);
      if (statusCode == 200) {
        var json = value.body;
        print("Result insert: $json");
        emit(InsertConsumableloaded(statusCode: statusCode, json: {"message": "Berhasil !"}));
      } else {
        var json = jsonDecode(value.body);
        emit(InsertConsumableloaded(statusCode: statusCode, json: json));
      }
    });
  }
}
