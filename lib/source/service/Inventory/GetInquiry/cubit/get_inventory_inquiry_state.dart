part of 'get_inventory_inquiry_cubit.dart';

@immutable
sealed class GetInventoryInquiryState {}

final class GetInventoryInquiryInitial extends GetInventoryInquiryState {}

final class GetInventoryInquiryLoading extends GetInventoryInquiryState {}

final class GetInventoryInquiryLoaded extends GetInventoryInquiryState {
  final int? statusCode;
  final List<ModelinventoryImquiry>? model;

  GetInventoryInquiryLoaded({required this.statusCode, required this.model});
}
