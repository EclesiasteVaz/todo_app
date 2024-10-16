import 'package:flutter/material.dart';

import 'package:todolist/src/data/models/task_model.dart';
import 'package:todolist/src/ui/bloc/tasks/task_bloc.dart';
import 'package:todolist/src/ui/bloc/tasks/task_event.dart';

class EditTaskPage extends StatefulWidget {
  final TaskModel task;
  final TaskBloc bloc;

  const EditTaskPage({
    super.key,
    required this.task,
    required this.bloc,
  });

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.task.title ?? '';
    contentController.text = widget.task.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criando uma tarefa"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: update,
            child: const Text("Guardar"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Insere o titulo da tarefa  - Opcional"),
              const SizedBox(height: 4),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Fazer compras"),
              ),
              const SizedBox(height: 20),
              const Text("Insere a descrição do que fazer"),
              const SizedBox(height: 4),
              TextFormField(
                controller: contentController,
                validator: validator,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      "Lista dos alimentos a comprar:\n1-Tomate\n2-Cebolas\n3-Cenoras\n\n\n\n",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? validator(String? text) {
    if (text == null || text.isEmpty) {
      return "O campo é obrigatório";
    }
    return null;
  }

  update() async {
    if (_formKey.currentState!.validate()) {
      widget.task.title = titleController.text;
      widget.task.content = contentController.text;
      widget.bloc.eventSink.add(TaskEventUpdate(task: widget.task));
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
