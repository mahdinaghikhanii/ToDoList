import 'package:flutter/material.dart';
import 'package:todolist/model/task_model.dart';
import 'package:todolist/widgets/mycheckbox.dart';

class TaskIteam extends StatefulWidget {
  const TaskIteam({super.key, required this.task});
  final TaskModel task;
  @override
  State<TaskIteam> createState() => _TaskIteamState();
}

class _TaskIteamState extends State<TaskIteam> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          widget.task.isCompleted = !widget.task.isCompleted;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.only(left: 16, right: 16),
        height: 84,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: themeData.colorScheme.surface),
        child: Row(
          children: [
            MyCheckBox(value: widget.task.isCompleted),
            const SizedBox(width: 16),
            Expanded(
              child: Text(widget.task.name,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 24,
                      overflow: TextOverflow.ellipsis,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null)),
            ),
          ],
        ),
      ),
    );
  }
}
