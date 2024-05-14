part of 'get_inventory_inquiry_detail_cubit.dart';

@immutable
sealed class GetInventoryInquiryDetailState {}

final class GetInventoryInquiryDetailInitial extends GetInventoryInquiryDetailState {}

final class GetInventoryInquiryDetailLoading extends GetInventoryInquiryDetailState {}

final class GetInventoryInquiryDetailLoaded extends GetInventoryInquiryDetailState {
  final int? statusCode;
  final List<ModelinventoryImquiryDetail>? model;

  GetInventoryInquiryDetailLoaded({required this.statusCode, required this.model});
}
