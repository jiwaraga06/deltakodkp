import 'package:deltakodkp/source/service/Consumable/Production/cubit/production_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductionUnit extends StatefulWidget {
  dynamic prodId, prodName;
  ProductionUnit({super.key, this.prodId, this.prodName});

  @override
  State<ProductionUnit> createState() => _ProductionUnitState();
}

class _ProductionUnitState extends State<ProductionUnit> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductionCubit, ProductionState>(
      builder: (context, state) {
        if (state is ProductionLoading) {
          return DropdownSearch(
            popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
            items: [].map((e) => e).toList(),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: "Production Unit",
                  labelText: "Production Unit",
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          );
        }
        if (state is ProductionLoaded == false) {
          return DropdownSearch(
            popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
            items: [].map((e) => e).toList(),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: "Production Unit",
                  labelText: "Production Unit",
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          );
        }
        var data = (state as ProductionLoaded).model!;
        return DropdownSearch(
          popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
          items: data.map((e) => e.prodUnitName).toList(),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                hintText: "Production Unit",
                labelText: "Production Unit",
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black)),
          ),
          selectedItem: widget.prodName,
          onChanged: (value) {
            setState(() {
              print("disana");
              data.where((e) => e.prodUnitName == value).forEach((a) {
                widget.prodId = a.prodUnitId;
                widget.prodName = a.prodUnitName;
              });
            });
          },
        );
      },
    );
  }
}
