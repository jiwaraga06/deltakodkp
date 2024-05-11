import 'dart:convert';

List<ModelConsumableMachineList> modelConsumableMachineListFromJson(String str) =>
    List<ModelConsumableMachineList>.from(json.decode(str).map((x) => ModelConsumableMachineList.fromJson(x)));

class ModelConsumableMachineList {
  final int? prodMachineId;
  final String? prodMachineCode;
  final String? prodMachineName;

  ModelConsumableMachineList({
    this.prodMachineId,
    this.prodMachineCode,
    this.prodMachineName,
  });

  factory ModelConsumableMachineList.fromJson(Map<String, dynamic> json) => ModelConsumableMachineList(
        prodMachineId: json["prod_machine_id"] ?? 0,
        prodMachineCode: json["prod_machine_code"] ?? "",
        prodMachineName: json["prod_machine_name"] ?? "",
      );
}
