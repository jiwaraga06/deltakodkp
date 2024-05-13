import 'package:deltakodkp/source/service/Consumable/Machine/cubit/machine_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Machine extends StatefulWidget {
  dynamic machineId, machineName;
  Machine({super.key, this.machineId, this.machineName});

  @override
  State<Machine> createState() => _MachineState();
}

class _MachineState extends State<Machine> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MachineCubit, MachineState>(
      builder: (context, state) {
        if (state is MachineLoading) {
          return DropdownSearch(
            popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
            items: [].map((e) => e).toList(),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: "Machine",
                  labelText: "Machine",
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          );
        }
        if (state is MachineLoaded == false) {
          return DropdownSearch(
            popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
            items: [].map((e) => e).toList(),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: "Machine",
                  labelText: "Machine",
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          );
        }
        var data = (state as MachineLoaded).model!;
        return DropdownSearch(
          popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
          items: data.map((e) => e.prodMachineName).toList(),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                hintText: "Machine",
                labelText: "Machine",
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black)),
          ),
          selectedItem: widget.machineName,
          onChanged: (value) {
            setState(() {
              print("disana");
              data.where((e) => e.prodMachineName == value).forEach((a) {
                widget.machineId = a.prodMachineId;
                widget.machineName = a.prodMachineName;
              });
            });
          },
        );
      },
    );
  }
}
