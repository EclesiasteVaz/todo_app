import 'package:sqflite/sqlite_api.dart';
import 'package:todolist/src/data/models/task_model.dart';

class TaskLocal {
  final List<TaskModel> tasks = [];
  final Database? database;

  TaskLocal({required this.database});

  readTasks() async {
    tasks.clear();
    final list = await database!.rawQuery("SELECT * FROM task");
    tasks.addAll(list.map((taskMap) => TaskModel.fromMap(taskMap)).toList());
  }

  addTask({required String content, String? title}) async {
    int lastId = await database!.rawInsert(
        'INSERT INTO task(title,content) VALUES("$title", "$content")');
    tasks.add(TaskModel(title: title, content: content, id: lastId));
  }

  deleteTask({required TaskModel task}) async {
    await database!.rawDelete('DELETE FROM task WHERE id=${task.id}');
    tasks.remove(task);
  }

  editTask({required TaskModel task}) async {
    await database!.rawUpdate("UPDATE task SET title=?, content=? WHERE id =?",
        [task.title, task.content, task.id]);
    await readTasks();
  }
}
