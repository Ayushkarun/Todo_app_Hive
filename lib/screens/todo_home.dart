import 'package:flutter/material.dart';
import 'package:hive_db_task/models/todo_model.dart';
import 'package:hive_db_task/service/todo_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final TodoService _todoService = TodoService();

  List<Todo> _todos = [];

  Future<void> _loadTodos() async {
    _todos = await _todoService.getTodos();
    setState(() {});
  }

  @override
  void initState() {
    _loadTodos();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog();
        },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(title: Text('ToDo')),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            final todo = _todos[index];
            return ListTile(
              onTap: () {
                _showEditDialog(todo,index);
              },
              title: Text("${todo.title}"),
              subtitle: Text("${todo.description}"),
              trailing: Checkbox(
                value: todo.completed,
                onChanged: (value) {
                  setState(() {
                    ///vale togglee
                    todo.completed=value!;
                    _todoService.updateTodo(index, todo);
                    setState(() {
                      
                    });
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showAddDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add details"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _descController,
                  decoration: InputDecoration(hintText: "Desc"),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final newTodo = Todo(
                  title: _titleController.text,
                  description: _descController.text,
                  createdAt: DateTime.now(),
                  completed: false,
                );
                await _todoService.addTodo(newTodo);
                _titleController.clear();
                _descController.clear();

                Navigator.pop(context);
                _loadTodos();

              },
              child: Text("Add"),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Cancel")),
          ],
        );
      },
    );
  }
  Future<void> _showEditDialog(Todo todo,int index) async {
    _titleController.text=todo.title;
_descController.text=todo.description;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _descController,
                  decoration: InputDecoration(hintText: "Desc"),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final newTodo = Todo(
                  title: _titleController.text,
                  description: _descController.text,
                  createdAt: DateTime.now(),
                  completed: false,
                );
                await _todoService.addTodo(newTodo);
                _titleController.clear();
                _descController.clear();

                Navigator.pop(context);
                _loadTodos();

              },
              child: Text("Edit"),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Cancel")),
          ],
        );
      },
    );
  }
}
