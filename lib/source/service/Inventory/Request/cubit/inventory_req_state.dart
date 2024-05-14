part of 'inventory_req_cubit.dart';

@immutable
sealed class InventoryReqState {}

final class InventoryReqInitial extends InventoryReqState {}

final class InventoryReqLoading extends InventoryReqState {}

final class InventoryReqLoaded extends InventoryReqState {
  final int? statusCode;
  final ModelinventoryRequest? model;

  InventoryReqLoaded({required this.statusCode, required this.model});
}
