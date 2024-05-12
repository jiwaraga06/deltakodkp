part of 'inventory_req_list_cubit.dart';

@immutable
sealed class InventoryReqConsumableListState {}

final class InventoryReqConsumableListInitial extends InventoryReqConsumableListState {}

final class InventoryReqConsumableListLoading extends InventoryReqConsumableListState {}

final class InventoryReqConsumableListLoaded extends InventoryReqConsumableListState {
  final int? statusCode;
  final List<ModelConsumableInventoryList>? model;

  InventoryReqConsumableListLoaded({required this.statusCode, required this.model});
}
