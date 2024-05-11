import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableInquiryDetail.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:meta/meta.dart';

part 'get_inquiry_detail_state.dart';

class GetInquiryDetailCubit extends Cubit<GetInquiryDetailState> {
  final RepositoryConsumable? repository;
  GetInquiryDetailCubit({this.repository}) : super(GetInquiryDetailInitial());

  void getInquiryDetail(issueCode, context) {
    emit(GetInquiryDetailLoading());
    repository!.getInquiryDetail(issueCode, context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("GET INQUIRY DETAIL: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
        emit(GetInquiryDetailLoaded(statusCode: statusCode, model: modelConsumableInquiryDetailFromJson(json)));
      } else {
        MyDialog.dialogAlert(context, "Maaf terjadi kesalahan");
        emit(GetInquiryDetailLoaded(statusCode: statusCode, model: modelConsumableInquiryDetailFromJson(jsonEncode([]))));
      }
    });
  }
}
