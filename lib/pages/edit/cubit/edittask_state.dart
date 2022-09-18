part of 'edittask_cubit.dart';

@immutable
abstract class EdittaskState {
  final TaskEntity task;
  const EdittaskState(this.task);
}

class EdittaskInitial extends EdittaskState {
  const EdittaskInitial(super.task);
}

class EditTaskPriorityChange extends EdittaskState {
  const EditTaskPriorityChange(super.task);
}
