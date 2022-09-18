import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todolist/pages/edit/cubit/edittask_cubit.dart';

import '../../data/data.dart';
import '../../data/repo/repository.dart';
import '../../main.dart';
import '../../widgets/priority_checkbox.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController(
        text: context.read<EdittaskCubit>().state.task.name);
    super.initState();
  }

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
            context.read<EdittaskCubit>().onSaveChnageClick();
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
            BlocBuilder<EdittaskCubit, EdittaskState>(
              builder: (BuildContext context, state) {
                final priority = state.task.priority;
                return Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 1,
                      child: PriorityCheckBox(
                        color: themeData.colorScheme.primary,
                        isSelected: priority == Priority.high,
                        label: 'High',
                        ontap: () {
                          context
                              .read<EdittaskCubit>()
                              .onPriorityChanged(Priority.high);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 1,
                      child: PriorityCheckBox(
                        color: normalPriority,
                        isSelected: priority == Priority.normal,
                        label: 'Normal',
                        ontap: () {
                          context
                              .read<EdittaskCubit>()
                              .onPriorityChanged(Priority.normal);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 1,
                      child: PriorityCheckBox(
                        color: lowPriority,
                        isSelected: priority == Priority.low,
                        label: 'Low',
                        ontap: () {
                          context
                              .read<EdittaskCubit>()
                              .onPriorityChanged(Priority.low);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            Expanded(
              child: TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.multiline,
                maxLength: null,
                maxLines: null,
                onChanged: (val) {
                  context.read<EdittaskCubit>().onTextChange(val);
                },
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
