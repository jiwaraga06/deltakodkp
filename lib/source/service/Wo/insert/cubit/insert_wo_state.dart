part of 'insert_wo_cubit.dart';

@immutable
sealed class InsertWoState {}

final class InsertWoInitial extends InsertWoState {}

final class InsertWoLoading extends InsertWoState {}

final class InsertWoLoaded extends InsertWoState {
  final int? statusCode;
  final dynamic json;

  InsertWoLoaded({required this.statusCode, required this.json});
}
