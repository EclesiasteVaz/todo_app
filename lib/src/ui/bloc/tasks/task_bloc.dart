import 'dart:async';

import 'package:todolist/src/domain/repositories/task_repository.dart';
import 'package:todolist/src/ui/bloc/tasks/task_event.dart';
import 'package:todolist/src/ui/bloc/tasks/task_state.dart';

class TaskBloc {
  final TaskRepository repository;

  final StreamController _stateController =
      StreamController<TaskState>.broadcast();
  get state => _stateController.stream;

  final StreamController _eventController =
      StreamController<TaskEvent>.broadcast();
  StreamSink get eventSink => _eventController.sink;

  TaskBloc({required this.repository}) {
    _eventController.stream.listen((event) async {
      _mapStateToEvent(event);
    });
  }

  Future _mapStateToEvent(TaskEvent event) async {
    _stateController.add(TaskStateLoading());
    if (event is TaskEventGetAll) {
      final tasks = await repository.getAll();
      _stateController.add(TaskStateSuccess(list: tasks));
    }

    if (event is TaskEventCreate) {
      final listTasks =
          await repository.create(title: event.title, content: event.content);
      _stateController.add(TaskStateSuccess(list: listTasks));
    }

    if (event is TaskEventDelete) {
      final listTasks = await repository.delete(task: event.task);
      _stateController.add(TaskStateSuccess(list: listTasks));
    }

    if (event is TaskEventUpdate) {
      final listTasks = await repository.edit(task: event.task);
      _stateController.add(TaskStateSuccess(list: listTasks));
    }
  }

  dipose() {
    _eventController.close();
    _stateController.close();
  }
}
