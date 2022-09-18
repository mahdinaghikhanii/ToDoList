import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data/data.dart';
import 'package:todolist/data/repo/repository.dart';

part 'edittask_state.dart';

class EdittaskCubit extends Cubit<EdittaskState> {
  final TaskEntity _taskEntity;
  final Repository<TaskEntity> repository;
  EdittaskCubit(this._taskEntity, this.repository)
      : super(EdittaskInitial(_taskEntity));
  void onSaveChnageClick() {
    repository.createOrUpdate(_taskEntity);
  }

  void onTextChange(String text) {
    _taskEntity.name = text;
  }

  void onPriorityChanged(Priority priority) {
    _taskEntity.priority = priority;
    emit(EditTaskPriorityChange(_taskEntity));
  }
}
