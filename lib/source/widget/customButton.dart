import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final Color? bkackgroundColor;
  final TextStyle? textStyle;
  const CustomButton({super.key, this.text, this.onTap, this.bkackgroundColor, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Ink(
        decoration: BoxDecoration(color: bkackgroundColor, borderRadius: BorderRadius.circular(8.0), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 1.3,
            spreadRadius: 1.3,
            offset: Offset(2, 2),
          )
        ]),
        child: Container(
          height: 50,
          margin: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              text!,
              style: textStyle
            ),
          ),
        ),
      ),
    );
  }
}
