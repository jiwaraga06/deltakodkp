part of 'inventory_req_cubit.dart';

@immutable
sealed class InventoryReqState {}

final class InventoryReqInitial extends InventoryReqState {}

final class InventoryReqloading extends InventoryReqState {}

final class InventoryReqloaded extends InventoryReqState {
  final int? statusCode;
  final ModelConsumableInventoryReq? model;

  InventoryReqloaded({required this.statusCode, required this.model});
}
