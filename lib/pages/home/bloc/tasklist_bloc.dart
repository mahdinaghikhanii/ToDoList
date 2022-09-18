import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data.dart';
import '../../../data/repo/repository.dart';

part 'tasklist_event.dart';
part 'tasklist_state.dart';

class TasklistBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository<TaskEntity> repository;
  TasklistBloc(this.repository) : super(TaskListInitial()) {
    on<TaskListEvent>((event, emit) async {
      if (event is TaskListStarted || event is TaskListSearch) {
        final String searchTerm;
        emit(TaskListLoading());
        if (event is TaskListSearch) {
          searchTerm = event.searchTerm;
        } else {
          searchTerm = '';
        }
        try {
          final iteam = await repository.getAll(searchKeyword: searchTerm);
          if (iteam.isNotEmpty) {
            emit(TaskListSucces(iteam));
          } else {
            emit(TaskListEmpty());
          }
        } catch (e) {
          emit(TaskListError("خطای نامشخص"));
        }
      } else if (event is TaskListDeleteAll) {
        await repository.deleteAll();
        emit(TaskListEmpty());
      }
    });
  }
}
