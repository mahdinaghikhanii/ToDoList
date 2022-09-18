import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/repo/repository.dart';

import '../../data/data.dart';
import '../../widgets/notfound.dart';
import '../../widgets/task_list.dart';
import '../edit/edit_task_page.dart';
import 'bloc/tasklist_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditTaskPage(taskEntity: TaskEntity())));
          },
          label: Row(
            children: const [
              Text("Add New Task"),
              SizedBox(width: 5),
              Icon(CupertinoIcons.checkmark_alt_circle)
            ],
          )),
      body: BlocProvider<TasklistBloc>(
        create: (context) =>
            TasklistBloc(context.read<Repository<TaskEntity>>()),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  themeData.colorScheme.primary,
                  themeData.colorScheme.primaryVariant
                ])),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "To Do List",
                            style: themeData.textTheme.titleLarge!
                                .apply(color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              CupertinoIcons.share_up,
                              color: themeData.colorScheme.onPrimary,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 38,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: themeData.colorScheme.onPrimary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 30,
                            )
                          ],
                        ),
                        child: Builder(
                          builder: (context) {
                            return TextField(
                              controller: controller,
                              onChanged: (value) {
                                context
                                    .read<TasklistBloc>()
                                    .add(TaskListSearch(value));
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(CupertinoIcons.search),
                                  label: Text('Search tasks...')),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(child: Consumer<Repository<TaskEntity>>(
                builder: (context, value, child) {
                  context.read<TasklistBloc>().add(TaskListStarted());
                  return BlocBuilder<TasklistBloc, TaskListState>(
                      builder: ((context, state) {
                    if (state is TaskListSucces) {
                      return TaskList(themeData: themeData, itesm: state.iteam);
                    } else if (state is TaskListEmpty) {
                      return const Center(child: NotFound());
                    } else if (state is TaskListLoading ||
                        state is TaskListInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TaskListError) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      throw Exception("state is not valid");
                    }
                  }));
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
