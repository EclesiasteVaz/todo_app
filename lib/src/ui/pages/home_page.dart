import 'package:flutter/material.dart';
import 'package:todolist/core/db_local.dart';
import 'package:todolist/core/task_local.dart';
import 'package:todolist/src/data/repositories/task_repositoy_impl.dart';
import 'package:todolist/src/domain/repositories/task_repository.dart';
import 'package:todolist/src/ui/bloc/tasks/task_bloc.dart';
import 'package:todolist/src/ui/bloc/tasks/task_event.dart';
import 'package:todolist/src/ui/bloc/tasks/task_state.dart';
import 'package:todolist/src/ui/pages/create_task_page.dart';
import 'package:todolist/src/ui/pages/show_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TaskRepository repository;
  late TaskBloc taskBloc;
  final taskLocal = TaskLocal(database: dbLocal.database!);

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  _initializeServices() async {
    repository = TaskRepositoyImpl(taskLocal: taskLocal);
    taskBloc = TaskBloc(repository: repository);
    taskBloc.eventSink.add(TaskEventGetAll());
  }

  @override
  void dispose() {
    taskBloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de tarefas",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: StreamBuilder(
        stream: taskBloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is TaskStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TaskStateSuccess) {
            if (state.list.isEmpty) {
              return const Center(
                child: Text("Não foi encontrada alguma tarefa"),
              );
            }

            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final task = state.list[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowTaskPage(
                        task: task,
                        bloc: taskBloc,
                      ),
                    ),
                  ),
                  title: Text(task.title != ''
                      ? (task.title!.length >= 50)
                          ? task.title!.substring(0, 50)
                          : task.title!
                      : "Sem titulo"),
                  subtitle: Text(task.content, maxLines: 1),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Adicionar tarefa",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => CreateTaskPage(
                    saveFunction: taskSave,
                  )),
        ),
      ),
    );
  }

  taskSave({required String content, String? title}) {
    taskBloc.eventSink.add(TaskEventCreate(title: title, content: content));
  }
}
