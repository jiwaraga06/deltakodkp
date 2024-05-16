import 'package:deltakodkp/source/env/env.dart';
import 'package:deltakodkp/source/service/Consumable/Location/cubit/location_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationConsumable extends StatefulWidget {
  LocationConsumable({super.key});

  @override
  State<LocationConsumable> createState() => _LocationConsumableState();
}

class _LocationConsumableState extends State<LocationConsumable> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationConsumableCubit, LocationConsumableState>(
      builder: (context, state) {
        if (state is LocationConsumableLoading) {
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
        if (state is LocationConsumableLoaded == false) {
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
        var data = (state as LocationConsumableLoaded).model!;
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
          onChanged: (value) {
            setState(() {
              print("disana");
              data.where((e) => e.locDesc == value).forEach((a) {
                loclocationCid = a.locId;
                loclocationCDesc = a.locDesc;
                
              });
            });
          },
        );
      },
    );
  }
}
