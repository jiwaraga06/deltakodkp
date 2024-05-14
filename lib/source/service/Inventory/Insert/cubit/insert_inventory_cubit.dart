import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/env/env.dart';
import 'package:deltakodkp/source/repository/repositoryInventory.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'insert_inventory_state.dart';

class InsertInventoryCubit extends Cubit<InsertInventoryState> {
  final RepositoryInventory? repository;
  InsertInventoryCubit({this.repository}) : super(InsertInventoryInitial());

  void insert(date, enId, branchId, reqOid, reqCode, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString("username");
    var body = {
      "issue_date": "$date",
      "en_id": "$enId",
      "branch_id": "$branchId",
      "request_oid": "$reqOid",
      "request_code": "$reqCode",
      "add_by": "$username",
      "inventoryIssueDetail": inputInventory
    };
    emit(InsertInventoryloading());
    repository!.insertInventory(jsonEncode(body), context).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        var json = value.body;
        emit(InsertInventoryloaded(statusCode: statusCode, json: json));
      } else {
        var json = jsonDecode(value.body);
        emit(InsertInventoryloaded(statusCode: statusCode, json: json));
      }
    });
  }
}
