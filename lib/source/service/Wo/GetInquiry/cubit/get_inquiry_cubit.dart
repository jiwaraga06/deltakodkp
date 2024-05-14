import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Wo/modelInquiry.dart';
import 'package:deltakodkp/source/repository/repositoryWo.dart';
import 'package:deltakodkp/source/widget/customDialog.dart';
import 'package:meta/meta.dart';

part 'get_inquiry_state.dart';

class GetInquiryCubit extends Cubit<GetInquiryState> {
  final RepositoryWo? repository;
  GetInquiryCubit({this.repository}) : super(GetInquiryInitial());

  void getInquiry(startdate, enddate, context) async {
    emit(GetInquiryLoading());
    repository!.getInquiry(context, startdate, enddate).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        var json = value.body;
      print("json: $json");
        emit(GetInquiryLoaded(statusCode: statusCode, model: modelInquiryFromJson(json)));
      } else {
        var json = jsonDecode(value.body);
      print("json: $json");
        MyDialog.dialogAlert(context, json['message']);
        emit(GetInquiryLoaded(statusCode: statusCode, model: modelInquiryFromJson(jsonEncode([]))));

      }
    });
  }
}
