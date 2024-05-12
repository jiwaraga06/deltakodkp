import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableInquiryDetail.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:meta/meta.dart';

part 'get_inquiry_detail_state.dart';

class GetInquiryDetailConsumableCubit extends Cubit<GetInquiryDetailConsumableState> {
  final RepositoryConsumable? repository;
  GetInquiryDetailConsumableCubit({this.repository}) : super(GetInquiryDetailConsumableInitial());

  void getInquiryDetail(issueCode, context) {
    emit(GetInquiryDetailConsumableLoading());
    repository!.getInquiryDetail(issueCode, context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("GET INQUIRY DETAIL: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
        emit(GetInquiryDetailConsumableLoaded(statusCode: statusCode, model: modelConsumableInquiryDetailFromJson(json)));
      } else {
        MyDialog.dialogAlert(context, "Maaf terjadi kesalahan");
        emit(GetInquiryDetailConsumableLoaded(statusCode: statusCode, model: modelConsumableInquiryDetailFromJson(jsonEncode([]))));
      }
    });
  }
}
