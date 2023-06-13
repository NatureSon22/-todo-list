import 'package:flutter/material.dart';
import 'package:todo/components/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List<dynamic> todoList = [];

  @override
  void initState() {
    super.initState();
    loadTodoList();
  }

  Future<void> loadTodoList() async {
    List<dynamic>? storedList = await getTodo();
    setState(() {
      todoList = storedList ?? [];
    });
  }

  Future<List<dynamic>?> getTodo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList('todos');
  }

  Future<void> setTodo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('todos', todoList.cast<String>());
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = value;
      setTodo();
    });
  }

  void saveTask() {
    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
      setTodo();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveTask,
          onCancel: () {
            Navigator.of(context).pop();
            _controller.clear();
          },
        );
      },
    );
  }

  void deleteTask(int index, BuildContext context) {
    setState(() {
      if (!todoList[index][1]) {
        todoList.removeAt(index);
        setTodo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: todoList[index][0],
              taskCompleted: todoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteTask: (context) {
                deleteTask(index, context);
              },
            );
          },
        ),
      ),
    );
  }
}
