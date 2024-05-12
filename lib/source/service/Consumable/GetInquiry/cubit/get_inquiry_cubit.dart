import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Consumable/modelConsumableInquiry.dart';
import 'package:deltakodkp/source/repository/repositoryConsumable.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:meta/meta.dart';

part 'get_inquiry_state.dart';

class GetInquiryConsumableCubit extends Cubit<GetInquiryConsumableState> {
  final RepositoryConsumable? repository;
  GetInquiryConsumableCubit({this.repository}) : super(GetInquiryConsumableInitial());

  void getInquiry(startdate, enddate, context) async {
    emit(GetInquiryConsumableLoading());
    repository!.getInquiry(context, startdate, enddate).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("Get INQUIRY: $json");
      if (statusCode == 401) {
      } else if (statusCode == 200) {
        emit(GetInquiryConsumableLoaded(statusCode: statusCode, model: modelConsumableInquiryFromJson(json)));
      } else {
        MyDialog.dialogAlert(context, "Maaf terjadi kesalahan");
        emit(GetInquiryConsumableLoaded(statusCode: statusCode, model: modelConsumableInquiryFromJson(jsonEncode([]))));
      }
    });
  }
}
