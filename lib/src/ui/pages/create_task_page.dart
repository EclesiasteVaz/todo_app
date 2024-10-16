import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  final Function({required String content, String? title}) saveFunction;
  const CreateTaskPage({super.key, required this.saveFunction});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criando uma tarefa"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: validateToSave,
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

  validateToSave() async {
    if (_formKey.currentState!.validate()) {
      await widget.saveFunction(
          title: titleController.text, content: contentController.text);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
