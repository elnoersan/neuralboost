import 'package:firebase_auth/firebase_auth.dart'
    as firebase_auth; // Import Firebase Auth
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Database
import 'package:flutter/material.dart';
import 'package:neuralboost/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoViewModel extends ChangeNotifier {
  List<Todo> _todos = [];
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Getter to access the list of todos
  List<Todo> get todos => _todos;

  TodoViewModel() {
    // Load todos from Firebase when the ViewModel is initialized
    _loadTodosFromFirebase();
  }

  // Load todos from Firebase
  Future<void> _loadTodosFromFirebase() async {
    final userId = firebase_auth
        .FirebaseAuth.instance.currentUser!.uid; // Get current user ID
    final todosRef = _database.child('users').child(userId).child('todos');

    final snapshot = await todosRef.get();
    if (snapshot.exists) {
      final todosMap = Map<String, dynamic>.from(snapshot.value as Map);
      _todos = todosMap.entries.map((entry) {
        return Todo(
          id: entry.key,
          title: entry.value['title'],
          description: entry.value['description'],
          targetDate: DateTime.parse(entry.value['targetDate']),
          isCompleted: entry.value['isCompleted'] ?? false,
        );
      }).toList();
      notifyListeners();
    }
  }

  // Add a new Todo
  void addTodo(String title, String description, DateTime targetDate) {
    final newTodo = Todo(
      id: const Uuid().v4(), // Generate a unique ID
      title: title,
      description: description,
      targetDate: targetDate,
    );
    _todos.add(newTodo);
    _saveTodoToFirebase(newTodo); // Save to Firebase
    notifyListeners(); // Notify listeners to update the UI
  }

  // Save a Todo to Firebase
  Future<void> _saveTodoToFirebase(Todo todo) async {
    final userId = firebase_auth
        .FirebaseAuth.instance.currentUser!.uid; // Get current user ID
    final todosRef = _database.child('users').child(userId).child('todos');
    await todosRef.child(todo.id).set({
      'title': todo.title,
      'description': todo.description,
      'targetDate': todo.targetDate.toIso8601String(),
      'isCompleted': todo.isCompleted,
    });
  }

  // Update an existing Todo
  void updateTodo(Todo updatedTodo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
      _saveTodoToFirebase(updatedTodo); // Update in Firebase
      notifyListeners();
    }
  }

  // Delete a Todo
  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _deleteTodoFromFirebase(id); // Delete from Firebase
    notifyListeners();
  }

  // Delete a Todo from Firebase
  Future<void> _deleteTodoFromFirebase(String id) async {
    final userId = firebase_auth
        .FirebaseAuth.instance.currentUser!.uid; // Get current user ID
    final todosRef = _database.child('users').child(userId).child('todos');
    await todosRef.child(id).remove();
  }

  // Toggle the completion status of a Todo
  void toggleTodoCompletion(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] =
          _todos[index].copyWith(isCompleted: !_todos[index].isCompleted);
      _saveTodoToFirebase(_todos[index]); // Update in Firebase
      notifyListeners();
    }
  }
}
