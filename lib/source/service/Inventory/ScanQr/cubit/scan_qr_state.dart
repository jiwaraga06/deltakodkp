part of 'scan_qr_cubit.dart';

@immutable
sealed class ScanQrState {}

final class ScanQrInitial extends ScanQrState {}

final class ScanQrLoading extends ScanQrState {}

final class ScanQrLoaded extends ScanQrState {
  final int? statusCode;
  final ModelinventoryScamQr? model;

  ScanQrLoaded({required this.statusCode, required this.model});
}
