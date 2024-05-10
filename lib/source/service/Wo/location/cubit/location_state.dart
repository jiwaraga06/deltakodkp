part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationLoaded extends LocationState {
  final int? statusCode;
  final List<ModelLocationList>? model;

  LocationLoaded({required this.statusCode, required this.model});
}
