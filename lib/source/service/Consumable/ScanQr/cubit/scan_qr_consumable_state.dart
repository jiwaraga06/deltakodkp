part of 'scan_qr_consumable_cubit.dart';

@immutable
sealed class ScanQrConsumableState {}

final class ScanQrConsumableInitial extends ScanQrConsumableState {}
final class ScanQrConsumableLoading extends ScanQrConsumableState {}
final class ScanQrConsumableLoaded extends ScanQrConsumableState {
  final int? statusCode;
  final ModelConsumableScanQr? model;

  ScanQrConsumableLoaded({required this.statusCode, required this.model});
}
