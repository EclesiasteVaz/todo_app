import 'package:sqflite/sqflite.dart';
import 'package:todolist/core/db_config.dart';

class DbLocal {
  final String path;
  Database? _database;

  Database? get database => _database;
  DbLocal._({required this.path}) {
    start();
  }

  start() async {
    await _openDb();
  }

  _openDb() async {
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)");
  }
}

DbLocal dbLocal = DbLocal._(path: DbConfig.path);
