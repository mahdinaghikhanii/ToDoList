import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/repo/repository.dart';
import '../widgets/notfound.dart';
import '../widgets/task_list.dart';

import '../data/data.dart';
import 'edit_task_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<String> searchKeywordNotifure = ValueNotifier('');

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
      body: SafeArea(
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
                      child: TextField(
                        controller: controller,
                        onChanged: (val) {
                          searchKeywordNotifure.value = controller.text;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.search),
                            label: Text('Search tasks...')),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<String>(
                  valueListenable: searchKeywordNotifure,
                  builder: (context, value, child) {
                    final repository =
                        Provider.of<Repository<TaskEntity>>(context);
                    return Consumer<Repository<TaskEntity>>(
                        builder: (context, value, child) {
                      return FutureBuilder<List<TaskEntity>>(
                          future:
                              repository.getAll(searchKeyword: controller.text),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isNotEmpty) {
                                return TaskList(
                                    themeData: themeData,
                                    itesm: snapshot.data!);
                              } else {
                                return const Center(child: NotFound());
                              }
                            } else {
                              return const CircularProgressIndicator();
                            }
                          });
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
