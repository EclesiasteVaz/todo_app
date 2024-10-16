import 'package:flutter/material.dart';
import 'package:todolist/src/data/models/task_model.dart';
import 'package:todolist/src/ui/bloc/tasks/task_bloc.dart';
import 'package:todolist/src/ui/bloc/tasks/task_event.dart';
import 'package:todolist/src/ui/pages/edit_task_page.dart';

class ShowTaskPage extends StatelessWidget {
  const ShowTaskPage({super.key, required this.task, required this.bloc});
  final TaskModel task;
  final TaskBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => EditTaskPage(task: task, bloc: bloc),
              ),
            ),
            icon: const Icon(Icons.edit_document),
          ),
          IconButton(
            onPressed: () {
              taskDelete(task: task);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Titulo: ${task.title == '' ? 'Sem titulo' : task.title}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(task.content)
            ],
          ),
        ),
      ),
    );
  }

  taskDelete({required TaskModel task}) {
    bloc.eventSink.add(TaskEventDelete(task: task));
  }
}
