import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:deltakodkp/source/model/Wo/modelInquiryDetail.dart';
import 'package:deltakodkp/source/repository/repositoryWo.dart';
import 'package:meta/meta.dart';

part 'get_inquiry_detail_state.dart';

class GetInquiryDetailCubit extends Cubit<GetInquiryDetailState> {
  final RepositoryWo? repository;
  GetInquiryDetailCubit({this.repository}) : super(GetInquiryDetailInitial());

  void getInquiryDetail(issueCode, context) async {
    emit(GetInquiryDetailLoading());
    repository!.getInquiryDetail(issueCode, context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("Inquiry Detail: $json");
      emit(GetInquiryDetailLoaded(statusCode: statusCode, model: modelInquiryDetailFromJson(json)));
    });
  }
}
