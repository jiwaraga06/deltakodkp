part of 'insert_consumable_cubit.dart';

@immutable
sealed class InsertConsumableState {}

final class InsertConsumableInitial extends InsertConsumableState {}
final class InsertConsumableloading extends InsertConsumableState {}
final class InsertConsumableloaded extends InsertConsumableState {
  final int? statusCode;
  final dynamic json;

  InsertConsumableloaded({required this.statusCode, required this.json});
}
