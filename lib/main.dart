import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Future<Database> db = openDatabase(
    join(await getDatabasesPath(), 'tasks_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)",
      );
    },
    version: 1
  );

  runApp(Application(database: db));
}