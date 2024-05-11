part of 'production_cubit.dart';

@immutable
sealed class ProductionState {}

final class ProductionInitial extends ProductionState {}

final class ProductionLoading extends ProductionState {}

final class ProductionLoaded extends ProductionState {
  final int? statusCode;
  final List<ModelConsumableLocationList>? model;

  ProductionLoaded({required this.statusCode, required this.model});
}
