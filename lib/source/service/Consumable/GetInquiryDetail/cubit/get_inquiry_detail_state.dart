part of 'get_inquiry_detail_cubit.dart';

@immutable
sealed class GetInquiryDetailState {}

final class GetInquiryDetailInitial extends GetInquiryDetailState {}

final class GetInquiryDetailLoading extends GetInquiryDetailState {}

final class GetInquiryDetailLoaded extends GetInquiryDetailState {
  final int? statusCode;
  final List<ModelConsumableInquiryDetail>? model;

  GetInquiryDetailLoaded({required this.statusCode, required this.model});
}
