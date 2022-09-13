import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/main.dart';

class MyCheckBox extends StatelessWidget {
  final bool value;
  const MyCheckBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            color: value ? primaryColor : null,
            borderRadius: BorderRadius.circular(12),
            border: !value
                ? Border.all(width: 2, color: secondaryTextColor)
                : null),
        child: value
            ? Icon(
                CupertinoIcons.check_mark,
                color: themeData.colorScheme.onPrimary,
                size: 16,
              )
            : null);
  }
}
