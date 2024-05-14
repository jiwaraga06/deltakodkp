part of 'insert_inventory_cubit.dart';

@immutable
sealed class InsertInventoryState {}

final class InsertInventoryInitial extends InsertInventoryState {}

final class InsertInventoryloading extends InsertInventoryState {}

final class InsertInventoryloaded extends InsertInventoryState {
  final int? statusCode;
  final dynamic json;

  InsertInventoryloaded({required this.statusCode, required this.json});
}
