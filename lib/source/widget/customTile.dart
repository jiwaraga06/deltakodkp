import 'package:deltakodkp/source/env/env.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? leading, title, subtitle, trailing;
  final Color? color, splashColor;
  const CustomTile({super.key, this.onTap, this.leading, this.title, this.subtitle, this.trailing, this.color, this.splashColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        splashColor: splashColor,
        onTap: onTap,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
