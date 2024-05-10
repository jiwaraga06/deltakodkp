part of 'material_request_cubit.dart';

@immutable
sealed class MaterialRequestState {}

final class MaterialRequestInitial extends MaterialRequestState {}

final class MaterialRequestLoading extends MaterialRequestState {}

final class MaterialRequestLoaded extends MaterialRequestState {
  final int? statusCode;
  final ModelMaterialReq? model;

  MaterialRequestLoaded({required this.statusCode, required this.model});
}
