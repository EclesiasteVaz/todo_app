import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConfig {
  static String path = '';
  static Future initiliaze() async {
    path = join(await getDatabasesPath(), 'todo.db');
  }
}
