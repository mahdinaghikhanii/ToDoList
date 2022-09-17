import 'package:flutter/material.dart';

import '../main.dart';
import '../data/data.dart';
import '../pages/bottom_sheet.dart';
import '../pages/edit_task_page.dart';
import 'mycheckbox.dart';

class TaskIteam extends StatefulWidget {
  const TaskIteam({super.key, required this.task});
  final TaskEntity task;
  @override
  State<TaskIteam> createState() => _TaskIteamState();
}

class _TaskIteamState extends State<TaskIteam> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final Color priorityColor;
    switch (widget.task.priority) {
      case Priority.low:
        priorityColor = lowPriority;
        break;
      case Priority.normal:
        priorityColor = normalPriority;
        break;
      case Priority.high:
        priorityColor = themeData.colorScheme.primary;
        break;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditTaskPage(taskEntity: widget.task)));
      },
      onLongPress: () {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return BottomShitIteamText(taskEntity: widget.task);
            });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        height: 74,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: themeData.colorScheme.surface),
        child: Row(
          children: [
            MyCheckBox(
              value: widget.task.isCompleted,
              ontap: () {
                setState(() {
                  widget.task.isCompleted = !widget.task.isCompleted;
                });
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(widget.task.name,
                  maxLines: 1,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null)),
            ),
            Container(
              width: 4,
              height: 84,
              decoration: BoxDecoration(
                color: priorityColor,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
