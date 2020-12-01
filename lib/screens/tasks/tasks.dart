import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/screens/tasks/add_button.dart';
import 'package:task_app/screens/tasks/task_widget.dart';
import 'package:task_app/style.dart';
import 'package:task_app/widgets/page.dart';
import 'package:task_app/widgets/title_text.dart';

import 'package:sqflite/sqflite.dart';

class Tasks extends StatefulWidget {
  final Future<Database> _database;

  Tasks(this._database);

  @override
  State<StatefulWidget> createState() {
    return _TasksState(_database);
  }
}

class _TasksState extends State<Tasks> {
  final Future<Database> _database;
  List<Task> _tasks = [];

  _TasksState(this._database);

  @override
  void initState() {
    fetchTasks().then((value) {
      setState(() {
        _tasks = value;
      });
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(child: Container()),
                  TitleText('Tarefas'),
                  AddButton(() => insertTask(Task('Nova Tarefa')))
                ],
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  itemCount: _tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: ValueKey(_tasks[index].id.toString() + index.toString()),
                      child: TaskWidget(_tasks[index], (text) => _tasks[index].name = text, (text) => updateTask(_tasks[index])),
                      onDismissed: (direction) {
                        deleteTask(_tasks[index].id, index).then((value) => setState(() => _tasks.removeAt(index)));
                      },
                      background: Container(
                        color: CheckColor,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(Icons.check),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(color: TextColor),
                ),
              )
            ],
          ),
        )
    );
  }

  Future<List<Task>> fetchTasks() async {
    final Database db = await _database;

    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<void> insertTask(Task task) async {
    final Database db = await _database;

    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ).then((value) {
      task.id = value;
      setState(() {
        _tasks.add(task);
      });
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await _database;

    await db.update(
      'tasks',
      task.toMap(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id, int index) async {
    final db = await _database;

    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}