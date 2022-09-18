part of 'tasklist_bloc.dart';

@immutable
abstract class TaskListState {}

class TaskListInitial extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListSucces extends TaskListState {
  final List<TaskEntity> iteam;
  TaskListSucces(this.iteam);
}

class TaskListEmpty extends TaskListState {}

class TaskListError extends TaskListState {
  final String errorMessage;
  TaskListError(this.errorMessage);
}
