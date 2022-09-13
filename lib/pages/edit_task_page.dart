import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../main.dart';
import '../model/task_model.dart';

import '../widgets/priority_checkbox.dart';

class EditTaskPage extends StatefulWidget {
  final TaskModel taskModel;
  const EditTaskPage({super.key, required this.taskModel});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController textEditingController =
      TextEditingController(text: widget.taskModel.name);
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: themeData.colorScheme.surface,
        foregroundColor: themeData.colorScheme.onSurface,
        title: const Text('Edit Task'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);

            widget.taskModel.name = textEditingController.text;
            widget.taskModel.priority = widget.taskModel.priority;
            if (widget.taskModel.isInBox) {
              widget.taskModel.save();
            } else {
              final Box<TaskModel> box = Hive.box(taskBoxName);
              box.add(widget.taskModel);
            }

            // task.name = textEditingController.
          },
          label: Row(
            children: const [
              Text('Save Changes'),
              SizedBox(width: 5),
              Icon(
                CupertinoIcons.check_mark,
                size: 18,
              )
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    color: themeData.colorScheme.primary,
                    isSelected: widget.taskModel.priority == Priority.high,
                    label: 'High',
                    ontap: () {
                      setState(() {
                        widget.taskModel.priority = Priority.high;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    color: normalPriority,
                    isSelected: widget.taskModel.priority == Priority.normal,
                    label: 'Normal',
                    ontap: () {
                      setState(() {
                        widget.taskModel.priority = Priority.normal;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    color: lowPriority,
                    isSelected: widget.taskModel.priority == Priority.low,
                    label: 'Low',
                    ontap: () {
                      setState(() {
                        widget.taskModel.priority = Priority.low;
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                controller: textEditingController,
                keyboardType: TextInputType.multiline,
                maxLength: null,
                maxLines: null,
                decoration: InputDecoration(
                    label: Text("Add a task for today",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(fontSizeFactor: 1.4))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
