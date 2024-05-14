part of 'scan_qr_non_ir_cubit.dart';

@immutable
sealed class ScanQrNonIrState {}

final class ScanQrNonIrInitial extends ScanQrNonIrState {}

final class ScanQrNonIrLoading extends ScanQrNonIrState {}

final class ScanQrNonIrLoaded extends ScanQrNonIrState {
  final int? statusCode;
  final ModelinventoryScamQrNonIr? model;

  ScanQrNonIrLoaded({required this.statusCode, required this.model});
}
