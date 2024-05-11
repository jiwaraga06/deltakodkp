import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableInquiry.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:meta/meta.dart';

part 'get_inquiry_state.dart';

class GetInquiryCubit extends Cubit<GetInquiryState> {
  final RepositoryConsumable? repository;
  GetInquiryCubit({this.repository}) : super(GetInquiryInitial());

  void getInquiry(startdate, enddate, context) async {
    emit(GetInquiryLoading());
    repository!.getInquiry(context, startdate, enddate).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("Get INQUIRY: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
        emit(GetInquiryLoaded(statusCode: statusCode, model: modelConsumableInquiryFromJson(json)));
      } else {
        MyDialog.dialogAlert(context, "Maaf terjadi kesalahan");
        emit(GetInquiryLoaded(statusCode: statusCode, model: modelConsumableInquiryFromJson(jsonEncode([]))));
      }
    });
  }
}
