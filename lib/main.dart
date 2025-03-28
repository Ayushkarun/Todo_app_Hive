import 'package:flutter/material.dart';
import 'package:hive_db_task/models/todo_model.dart';
import 'package:hive_db_task/screens/todo_home.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_db_task/service/todo_service.dart';//1



void main() async
{
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());

  await TodoService().openBox();//1
  runApp(App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
      title: "To do",
    );
  }
}