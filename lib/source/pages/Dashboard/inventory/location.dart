import 'package:deltakodkp/source/env/env.dart';
import 'package:deltakodkp/source/service/Inventory/Location/cubit/inventory_location_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Location extends StatefulWidget {
  dynamic locId, locName;
  Location({super.key, this.locId, this.locName});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryLocationCubit, InventoryLocationState>(
      builder: (context, state) {
        if (state is InventoryLocationloading) {
          return DropdownSearch(
            popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
            items: [].map((e) => e).toList(),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: "Location",
                  labelText: "Location",
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          );
        }
        if (state is InventoryLocationloaded == false) {
          return DropdownSearch(
            popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
            items: [].map((e) => e).toList(),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: "Location",
                  labelText: "Location",
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          );
        }
        var data = (state as InventoryLocationloaded).model!;
        return DropdownSearch(
          popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
          items: data.map((e) => e.locDesc).toList(),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                hintText: "Location",
                labelText: "Location",
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black)),
          ),
          selectedItem: locDescInv,
          onChanged: (value) {
            setState(() {
              print("disana");
              data.where((e) => e.locDesc == value).forEach((a) {
                locidInv = a.locId;
                locDescInv = a.locDesc;
              });
            });
          },
        );
      },
    );
  }
}
