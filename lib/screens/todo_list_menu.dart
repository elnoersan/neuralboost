// lib/screens/todo_list_menu.dart
import 'package:flutter/material.dart';

class TodoListMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Center(
        child: Text('To-Do List Content'),
      ),
    );
  }
}
