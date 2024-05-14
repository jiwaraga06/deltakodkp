part of 'inventory_location_cubit.dart';

@immutable
sealed class InventoryLocationState {}

final class InventoryLocationInitial extends InventoryLocationState {}

final class InventoryLocationloading extends InventoryLocationState {}

final class InventoryLocationloaded extends InventoryLocationState {
  final int? statusCode;
  final List<ModelinventoryLocation>? model;

  InventoryLocationloaded({required this.statusCode, required this.model});
}
