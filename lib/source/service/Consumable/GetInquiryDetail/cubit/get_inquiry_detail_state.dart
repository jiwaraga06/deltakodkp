part of 'get_inquiry_detail_cubit.dart';

@immutable
sealed class GetInquiryDetailConsumableState {}

final class GetInquiryDetailConsumableInitial extends GetInquiryDetailConsumableState {}

final class GetInquiryDetailConsumableLoading extends GetInquiryDetailConsumableState {}

final class GetInquiryDetailConsumableLoaded extends GetInquiryDetailConsumableState {
  final int? statusCode;
  final List<ModelConsumableInquiryDetail>? model;

  GetInquiryDetailConsumableLoaded({required this.statusCode, required this.model});
}
