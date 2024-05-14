import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Inventory/modelInventoryInquiry.dart';
import 'package:deltakodkp/source/repository/repositoryInventory.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:meta/meta.dart';

part 'get_inventory_inquiry_state.dart';

class GetInventoryInquiryCubit extends Cubit<GetInventoryInquiryState> {
  final RepositoryInventory? repository;
  GetInventoryInquiryCubit({this.repository}) : super(GetInventoryInquiryInitial());

  void getInventoryInquiry(startdate, enddate, context) async {
    emit(GetInventoryInquiryLoading());
    repository!.getInquiry(context, startdate, enddate).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        var json = value.body;
        print("Inv Inq: $json");
        emit(GetInventoryInquiryLoaded(statusCode: statusCode, model: modelinventoryImquiryFromJson(json)));
      } else {
        var json = jsonDecode(value.body);
        print("Inv Inq: $json");
        MyDialog.dialogAlert(context, json['message']);
        emit(GetInventoryInquiryLoaded(statusCode: statusCode, model: modelinventoryImquiryFromJson(jsonEncode([]))));
      }
    });
  }
}
