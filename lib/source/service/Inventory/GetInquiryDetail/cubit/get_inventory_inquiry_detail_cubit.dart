import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Inventory/modelInventoryInquiryDetail.dart';
import 'package:deltakodkp/source/repository/repositoryInventory.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:meta/meta.dart';

part 'get_inventory_inquiry_detail_state.dart';

class GetInventoryInquiryDetailCubit extends Cubit<GetInventoryInquiryDetailState> {
  final RepositoryInventory? repository;
  GetInventoryInquiryDetailCubit({this.repository}) : super(GetInventoryInquiryDetailInitial());

  void getInventoryInquiryDetail(issueCode, context) async {
    emit(GetInventoryInquiryDetailLoading());
    repository!.getInquiryDetail(issueCode, context).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        var json = value.body;
        print("Inv Inq Detail: $json");
        emit(GetInventoryInquiryDetailLoaded(statusCode: statusCode, model: modelinventoryImquiryDetailFromJson(json)));
      } else {
        var json = jsonDecode(value.body);
        print("Inv Inq Detail: $json");
        MyDialog.dialogAlert(context, json['message']);
        emit(GetInventoryInquiryDetailLoaded(statusCode: statusCode, model: modelinventoryImquiryDetailFromJson(jsonEncode([]))));
      }
    });
  }
}
