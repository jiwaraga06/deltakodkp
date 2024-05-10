part of 'qr_cubit.dart';

@immutable
sealed class QrState {}

final class QrInitial extends QrState {}

final class QrLoading extends QrState {}

final class QrLoaded extends QrState {
  final int? statusCode;
  final ModelScan? model;

  QrLoaded({required this.statusCode, required this.model});
}
