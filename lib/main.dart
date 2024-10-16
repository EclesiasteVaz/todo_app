import 'package:flutter/material.dart';
import 'package:todolist/core/db_config.dart';
import 'package:todolist/core/db_local.dart';
import 'package:todolist/src/ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbConfig.initiliaze();
  await dbLocal.start();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue[500]!, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
