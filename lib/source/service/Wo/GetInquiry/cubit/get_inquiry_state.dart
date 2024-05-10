part of 'get_inquiry_cubit.dart';

@immutable
sealed class GetInquiryState {}

final class GetInquiryInitial extends GetInquiryState {}

final class GetInquiryLoading extends GetInquiryState {}

final class GetInquiryLoaded extends GetInquiryState {
  final int? statusCode;
  final List<ModelInquiry>? model;

  GetInquiryLoaded({required this.statusCode, required this.model});
}
