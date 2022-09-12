import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todolist/main.dart';
import 'package:todolist/model/task_model.dart';
import 'package:todolist/pages/edit_task_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<TaskModel>(taskBoxName);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EditTaskPage()));
          },
          label: const Text("Add New Task")),
      appBar: AppBar(
        title: const Text("To Do List"),
      ),
      body: ListView.builder(
          itemCount: box.values.length,
          itemBuilder: ((context, index) {
            final TaskModel task = box.values.toList()[index];
            return SizedBox(
              child: Text(task.name),
            );
          })),
    );
  }
}
