import 'package:todolist/core/task_local.dart';
import 'package:todolist/src/data/models/task_model.dart';

abstract class TaskRepository {
  TaskLocal taskLocal;
  TaskRepository({required this.taskLocal});

  /// Responsável por pegar o array de tasks
  Future<List<TaskModel>> getAll();

  /// Responsável por armazenar um task
  Future<List<TaskModel>> create({required String content, String? title});

  /// Responsável por eliminar um tak
  Future<List<TaskModel>> delete({required TaskModel task});

  /// Responsável por editar um um task
  Future edit({required TaskModel task});
}
