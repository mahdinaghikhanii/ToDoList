import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist/main.dart';
import 'package:todolist/model/task_model.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final task = TaskModel();

          task.name = textEditingController.text;
          task.priority = Priority.low;
          if (task.isInBox) {
            task.save();
          } else {
            final Box<TaskModel> box = Hive.box(taskBoxName);
            box.add(task);
          }

          // task.name = textEditingController.
        },
        label: const Text('Save Changes'),
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
            decoration:
                const InputDecoration(label: Text("Add a task for today")),
          )
        ],
      ),
    );
  }
}
