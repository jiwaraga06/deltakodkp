part of 'location_cubit.dart';

@immutable
sealed class LocationConsumableState {}

final class LocationConsumableInitial extends LocationConsumableState {}

final class LocationConsumableLoading extends LocationConsumableState {}

final class LocationConsumableLoaded extends LocationConsumableState {
  final int? statusCode;
  final List<ModelConsumableLocationList>? model;

  LocationConsumableLoaded({required this.statusCode, required this.model});
}
