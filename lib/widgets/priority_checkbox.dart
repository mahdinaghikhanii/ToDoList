import 'package:flutter/material.dart';
import 'package:todolist/main.dart';
import 'package:todolist/widgets/chekbox_shape_priority.dart';

class PriorityCheckBox extends StatelessWidget {
  final bool isSelected;
  final Color color;
  final String label;
  final GestureTapCallback ontap;
  const PriorityCheckBox(
      {super.key,
      required this.isSelected,
      required this.color,
      required this.label,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  width: 2, color: secondaryTextColor.withOpacity(0.2))),
          child: Stack(
            children: [
              Center(
                child: Text(label),
              ),
              Positioned(
                  right: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                      child: CheckBoxShapePriority(
                          value: isSelected, color: color)))
            ],
          )),
    );
  }
}
