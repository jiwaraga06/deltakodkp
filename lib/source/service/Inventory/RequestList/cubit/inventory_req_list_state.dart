part of 'inventory_req_list_cubit.dart';

@immutable
sealed class InventoryReqListState {}

final class InventoryReqListInitial extends InventoryReqListState {}

final class InventoryReqListLoading extends InventoryReqListState {}

final class InventoryReqListLoaded extends InventoryReqListState {
  final int? statusCode;
  final List<ModelinventoryRequestList>? model;

  InventoryReqListLoaded({required this.statusCode, required this.model});
}
