import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'todo_model.g.dart';

//content of file are part of another file
//type adapter convert object into hive representation
////flutter packages pub run build_runner build
///dapters to allow Hive to store and retrieve custom objects (data models). 
///By default, Hive can only handle basic data types like int, String, bool, and List. 
///If you want to store complex objects (e.g., a Student model), you need to register an adapter.
@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late DateTime createdAt;

  @HiveField(3)
  late bool completed;

  Todo({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.completed,
  });
}
