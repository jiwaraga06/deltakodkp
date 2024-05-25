import 'package:deltakodkp/source/env/env.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText, labelText, messageError;
  final bool? readOnly, hidePassword;
  final Widget? preffixIcon, suffixIcon;
  final VoidCallback? onTap;
  TextInputType? keyboardType;
   CustomField(
      {super.key,
      this.hintText,
      this.labelText,
      this.messageError,
      this.readOnly,
      this.hidePassword,
      this.preffixIcon,
      this.suffixIcon,
      this.controller,
      this.keyboardType,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly!,
      obscureText: hidePassword!,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: preffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.8), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: colorBlueNavy,strokeAlign: 20),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return messageError;
        }
        return null;
      },
    );
  }
}
