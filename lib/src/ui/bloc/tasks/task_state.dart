import 'package:todolist/src/data/models/task_model.dart';

abstract class TaskState {}

class TaskStateLoading extends TaskState {}

class TaskStateSuccess extends TaskState {
  final List<TaskModel> list;

  TaskStateSuccess({required this.list});
}

class TaskStateError extends TaskState {}