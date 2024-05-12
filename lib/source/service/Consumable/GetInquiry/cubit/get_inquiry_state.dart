part of 'get_inquiry_cubit.dart';

@immutable
sealed class GetInquiryConsumableState {}

final class GetInquiryConsumableInitial extends GetInquiryConsumableState {}

final class GetInquiryConsumableLoading extends GetInquiryConsumableState {}

final class GetInquiryConsumableLoaded extends GetInquiryConsumableState {
  final int? statusCode;
  final List<ModelConsumableInquiry>? model;

  GetInquiryConsumableLoaded({required this.statusCode, required this.model});
}
