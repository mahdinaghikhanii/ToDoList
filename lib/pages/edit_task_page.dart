import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/repo/repository.dart';
import '../main.dart';
import '../data/data.dart';

import '../widgets/priority_checkbox.dart';

class EditTaskPage extends StatefulWidget {
  final TaskEntity taskEntity;
  const EditTaskPage({super.key, required this.taskEntity});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController textEditingController =
      TextEditingController(text: widget.taskEntity.name);
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
            widget.taskEntity.name = textEditingController.text;
            widget.taskEntity.priority = widget.taskEntity.priority;
            final provider =
                Provider.of<Repository<TaskEntity>>(context, listen: false);
            provider.createOrUpdate(widget.taskEntity);
            Navigator.pop(context);
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
                    isSelected: widget.taskEntity.priority == Priority.high,
                    label: 'High',
                    ontap: () {
                      setState(() {
                        widget.taskEntity.priority = Priority.high;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    color: normalPriority,
                    isSelected: widget.taskEntity.priority == Priority.normal,
                    label: 'Normal',
                    ontap: () {
                      setState(() {
                        widget.taskEntity.priority = Priority.normal;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    color: lowPriority,
                    isSelected: widget.taskEntity.priority == Priority.low,
                    label: 'Low',
                    ontap: () {
                      setState(() {
                        widget.taskEntity.priority = Priority.low;
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
