// ViewModel: Manages the state and business logic for the View
import 'package:flutter/material.dart';
import 'package:neuralboost/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoViewModel extends ChangeNotifier {
  List<Todo> _todos = [];

  // Getter to access the list of todos
  List<Todo> get todos => _todos;

  // Add a new Todo
  void addTodo(String title, String description, DateTime targetDate) {
    final newTodo = Todo(
      id: const Uuid().v4(), // Generate a unique ID
      title: title,
      description: description,
      targetDate: targetDate,
    );
    _todos.add(newTodo);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Update an existing Todo
  void updateTodo(Todo updatedTodo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
      notifyListeners();
    }
  }

  // Delete a Todo
  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  // Toggle the completion status of a Todo
  void toggleTodoCompletion(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] =
          _todos[index].copyWith(isCompleted: !_todos[index].isCompleted);
      notifyListeners();
    }
  }
}
