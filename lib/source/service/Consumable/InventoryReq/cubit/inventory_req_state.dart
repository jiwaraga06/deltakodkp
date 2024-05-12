part of 'inventory_req_cubit.dart';

@immutable
sealed class InventoryReqConsumableState {}

final class InventoryReqConsumableInitial extends InventoryReqConsumableState {}

final class InventoryReqConsumableloading extends InventoryReqConsumableState {}

final class InventoryReqConsumableloaded extends InventoryReqConsumableState {
  final int? statusCode;
  final ModelConsumableInventoryReq? model;

  InventoryReqConsumableloaded({required this.statusCode, required this.model});
}
