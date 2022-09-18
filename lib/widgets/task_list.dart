import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/pages/home/bloc/tasklist_bloc.dart';
import '../data/data.dart';
import '../data/repo/repository.dart';
import '../main.dart';
import 'task_iteam.dart';

class TaskList extends StatelessWidget {
  final ThemeData themeData;
  final List<TaskEntity> itesm;
  const TaskList({super.key, required this.themeData, required this.itesm});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        itemCount: itesm.length + 1,
        itemBuilder: ((context, index) {
          if (index == 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today',
                        style: themeData.textTheme.titleLarge!
                            .apply(fontSizeFactor: 0.9)),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 60,
                      height: 3,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(1.5)),
                    )
                  ],
                ),
                MaterialButton(
                    color: const Color(0xffEAEFF5),
                    onPressed: () {
                      context.read<TasklistBloc>().add(TaskListDeleteAll());
                    },
                    elevation: 0,
                    textColor: secondaryTextColor,
                    child: Row(
                      children: const [
                        Text("Delete All"),
                        SizedBox(width: 4),
                        Icon(CupertinoIcons.delete, size: 18),
                      ],
                    )),
              ],
            );
          } else {
            return Column(
              children: [
                const SizedBox(height: 10),
                TaskIteam(task: itesm[index - 1]),
              ],
            );
          }
        }));
  }
}
