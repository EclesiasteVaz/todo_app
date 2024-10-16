import 'package:todolist/core/task_local.dart';
import 'package:todolist/src/data/models/task_model.dart';
import 'package:todolist/src/domain/repositories/task_repository.dart';

class TaskRepositoyImpl implements TaskRepository {
  @override
  TaskLocal taskLocal;

  TaskRepositoyImpl({
    required this.taskLocal,
  });

  List<TaskModel> get tasks => taskLocal.tasks;

  @override
  Future<List<TaskModel>> getAll() async {
    await taskLocal.readTasks();
    return taskLocal.tasks;
  }

  @override
  Future edit({required TaskModel task}) async {
    await taskLocal.editTask(task: task);
    return taskLocal.tasks;
  }

  @override
  Future<List<TaskModel>> create(
      {required String content, String? title}) async {
    await taskLocal.addTask(content: content, title: title);
    return taskLocal.tasks;
  }

  @override
  Future<List<TaskModel>> delete({required TaskModel task}) async {
    await taskLocal.deleteTask(task: task);
    return taskLocal.tasks;
  }
}
