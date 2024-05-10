part of 'material_request_list_cubit.dart';

@immutable
sealed class MaterialRequestListState {}

final class MaterialRequestListInitial extends MaterialRequestListState {}

final class MaterialRequestListLoading extends MaterialRequestListState {}

final class MaterialRequestListLoaded extends MaterialRequestListState {
  final int? statusCode;
  final List<ModelMaterialList>? model;

  MaterialRequestListLoaded({required this.statusCode, required this.model});
}
