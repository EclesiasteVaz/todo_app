// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todolist/src/data/models/task_model.dart';

abstract class TaskEvent {}

class TaskEventCreate extends TaskEvent {
  final String? title;
  final String content;

  TaskEventCreate({required this.content, this.title});
}

class TaskEventDelete extends TaskEvent {
  final TaskModel task;
  TaskEventDelete({
    required this.task,
  });
}

class TaskEventGetAll extends TaskEvent {}

class TaskEventUpdate extends TaskEvent {
  final TaskModel task;
  TaskEventUpdate({
    required this.task,
  });
}
