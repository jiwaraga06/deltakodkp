import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/env/env.dart';
import 'package:deltakodkp/source/repository/repositoryWo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'insert_wo_state.dart';

class InsertWoCubit extends Cubit<InsertWoState> {
  final RepositoryWo? repository;
  InsertWoCubit({this.repository}) : super(InsertWoInitial());

  void insertWo(woiOid, enId, branchId, ccId, woId, woOid, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString("username");
    var datetime = DateTime.now();
    var body = {
      "issue_date": "$dateNow",
      "woi_oid": "$woiOid",
      "en_id": "$enId",
      "branch_id": "$branchId",
      "cc_id": "$ccId",
      "wo_id": "$woId",
      "wo_oid": "$woOid",
      "add_by": "$username",
      "add_date": datetime.toIso8601String(),
      "woIssueDetail": inputwo
    };
    print(body);
    emit(InsertWoLoading());
    repository!.insertWo(jsonEncode(body), context).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("Result insert: $json");
      print(statusCode);
      emit(InsertWoLoaded(statusCode: statusCode, json: json));
    });
  }
}
