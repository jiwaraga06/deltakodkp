import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Wo/modelMaterialReqList.dart';
import 'package:deltakodkp/source/repository/repositoryWo.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:meta/meta.dart';

part 'material_request_list_state.dart';

class MaterialRequestListCubit extends Cubit<MaterialRequestListState> {
  final RepositoryWo? repository;
  MaterialRequestListCubit({this.repository}) : super(MaterialRequestListInitial());
  var list = [];
  void getMaterialReqList(context) async {
    emit(MaterialRequestListLoading());
    repository!.getMaterialRequestList(context).then((value) {
      var json = value.body;
      list = jsonDecode(value.body);
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        print("MaterialReqList : $json");
        emit(MaterialRequestListLoaded(statusCode: statusCode, model: modelMaterialListFromJson(json)));
      } else {
        var json = jsonDecode(value.body);
        MyDialog.dialogAlert(context, json['message']);
        emit(MaterialRequestListLoaded(statusCode: statusCode, model: modelMaterialListFromJson(jsonEncode([]))));
      }
    });
  }

  void searchData(value) async {
    emit(MaterialRequestListLoading());

    var result = value;
    print('Result:  $result');
    print('list');
    // print(list);
    var hasil = list.where((e) => e['woi_code'].toLowerCase().contains(result.toLowerCase())).toList();
    print('hasil: $hasil');
    if (result == '') {
      print('Kosong');
      emit(MaterialRequestListLoaded(statusCode: 200, model: modelMaterialListFromJson(jsonEncode(list))));
    } else {
      print('ada');
      emit(MaterialRequestListLoaded(statusCode: 200, model: modelMaterialListFromJson(jsonEncode(hasil))));
    }
  }
}
