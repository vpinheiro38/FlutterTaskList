import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_app/screens/tasks/tasks.dart';
import 'package:task_app/style.dart';

class Application extends StatelessWidget {
  final Future<Database> database;

  Application({this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(headline1: TitleTextStyle, bodyText1: Body1TextStyle, bodyText2: Body2TextStyle)
      ),
      home: Tasks(database),
    );
  }

}