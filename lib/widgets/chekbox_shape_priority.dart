import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckBoxShapePriority extends StatelessWidget {
  final bool value;
  final Color color;

  const CheckBoxShapePriority({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: value
            ? Icon(
                CupertinoIcons.check_mark,
                color: themeData.colorScheme.onPrimary,
                size: 12,
              )
            : null);
  }
}
