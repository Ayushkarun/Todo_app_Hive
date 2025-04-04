import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_db_task/models/todo_model.dart';

class TodoService {
  Box<Todo>? _todoBox; ////ex string name (datatype name)

  Future<void> openBox() async {
    _todoBox = await Hive.openBox<Todo>('todo');
  }

  Future<void> closeBox() async {
    await _todoBox!.close();
  }

  //add
  Future<void> addTodo(Todo todo) async {///(type name ex int a)
    if (_todoBox == null) {///box ada illengil
      await openBox();
    }
    await _todoBox!.add(todo);
  }

  Future<List<Todo>> getTodos() async {///to get index and store in list return in list because it store in box each box contain all prperty in the class
    if (_todoBox == null) {
      await openBox();
    }
    return _todoBox!.values.toList();
  }

  Future<void> updateTodo(int index, Todo todo) async {
    if (_todoBox == null) {
      await openBox();
    }
    await _todoBox!.putAt(index, todo);
  }

  Future<void> deleteTodo(int index) async {
    if (_todoBox == null) {
      await openBox();
    }
    await _todoBox!.deleteAt(index);
  }
}
