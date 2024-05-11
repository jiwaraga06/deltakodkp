part of 'machine_cubit.dart';

@immutable
sealed class MachineState {}

final class MachineInitial extends MachineState {}

final class MachineLoading extends MachineState {}

final class MachineLoaded extends MachineState {
  final int? statusCode;
  final List<ModelConsumableMachineList>? model;

  MachineLoaded({required this.statusCode, required this.model});
}
