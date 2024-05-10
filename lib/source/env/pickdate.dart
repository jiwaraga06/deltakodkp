import 'package:flutter/material.dart';

Future pickDate(BuildContext context) async {
  var datetime;
  datetime = await showDatePicker(
    context: context,
    firstDate: DateTime(1900),
    lastDate: DateTime(5000),
    initialDate: DateTime.now(),
  );
  return datetime;
}
