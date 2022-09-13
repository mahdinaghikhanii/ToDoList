import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import '../main.dart';
import '../model/task_model.dart';
import 'edit_task_page.dart';
import '../widgets/task_iteam.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //  final TextEditingController search = TextEditingController();
    final box = Hive.box<TaskModel>(taskBoxName);
    final themeData = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditTaskPage(taskModel: TaskModel())));
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
                          onTap: () async {
                            await Share.share(box.name);
                          },
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
                        //   controller: search,
                        onChanged: (val) {},
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
              child: ValueListenableBuilder<Box<TaskModel>>(
                valueListenable: box.listenable(),
                builder: (context, box, child) {
                  if (box.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset('assets/lottie/task.json',
                            width: 250),
                        Center(
                            child: Text(
                          "Your task list is empty",
                          style: themeData.textTheme.titleLarge,
                        ))
                      ],
                    );
                  } else {
                    return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                        itemCount: box.values.length + 1,
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
                                          borderRadius:
                                              BorderRadius.circular(1.5)),
                                    )
                                  ],
                                ),
                                MaterialButton(
                                    color: const Color(0xffEAEFF5),
                                    onPressed: () {
                                      box.clear();
                                    },
                                    elevation: 0,
                                    textColor: secondaryTextColor,
                                    child: Row(
                                      children: const [
                                        Text("Delete All"),
                                        SizedBox(width: 4),
                                        Icon(CupertinoIcons.delete, size: 18),
                                      ],
                                    ))
                              ],
                            );
                          } else {
                            final TaskModel task =
                                box.values.toList()[index - 1];
                            return Column(
                              children: [
                                const SizedBox(height: 10),
                                TaskIteam(task: task),
                              ],
                            );
                          }
                        }));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
