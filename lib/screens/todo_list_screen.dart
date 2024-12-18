import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:neuralboost/models/todo_model.dart';
import 'package:neuralboost/services/gamificate_service.dart'; // Import GamificateService
import 'package:neuralboost/services/todo_view_model.dart';
import 'package:neuralboost/utils/app_theme.dart';
import 'package:provider/provider.dart';

class TodoListScreen extends StatelessWidget {
  final GamificateService _gamificateService =
      GamificateService(); // Instantiate GamificateService

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TodoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [],
      ),
      body: viewModel.todos.isEmpty
          ? Center(
              child: Text(
                'No tasks yet. Add a new task!',
                style: AppTheme.bodyMedium.copyWith(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(todo.description),
                      Text(
                        'Target Date: ${todo.targetDate.toLocal().toString().split(' ')[0]}',
                        style: AppTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditTodoDialog(context, viewModel, todo);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(todo.isCompleted
                              ? Icons.check_box
                              : Icons.check_box_outline_blank),
                          onPressed: () async {
                            // Toggle the task completion status
                            viewModel.toggleTodoCompletion(todo.id);

                            // Check if the task is now completed
                            final updatedTodo = viewModel.todos
                                .firstWhere((t) => t.id == todo.id);
                            if (updatedTodo.isCompleted) {
                              // Calculate points based on task difficulty or other criteria
                              int pointsToAward =
                                  calculateTaskPoints(updatedTodo);

                              // Award points when the task is completed
                              await _gamificateService.addPoints(pointsToAward);

                              // Show a snackbar to notify the user
                              Get.snackbar(
                                'Points Awarded',
                                'You earned $pointsToAward points for completing a task!',
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            _showDeleteConfirmationDialog(
                                context, viewModel, todo);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(
          onPressed: () {
            _showAddTodoDialog(context, viewModel);
          },
          child: Icon(Icons.add),
          backgroundColor: AppTheme.primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showAddTodoDialog(BuildContext context, TodoViewModel viewModel) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime? targetDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Task', style: AppTheme.titleMedium),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  targetDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                },
                child: Text('Select Target Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && targetDate != null) {
                  viewModel.addTodo(titleController.text,
                      descriptionController.text, targetDate!);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTodoDialog(
      BuildContext context, TodoViewModel viewModel, Todo todo) {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description);
    DateTime? targetDate = todo.targetDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task', style: AppTheme.titleMedium),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  targetDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                },
                child: Text('Select Target Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && targetDate != null) {
                  final updatedTodo = todo.copyWith(
                    title: titleController.text,
                    description: descriptionController.text,
                    targetDate: targetDate!,
                  );
                  viewModel.updateTodo(updatedTodo);
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, TodoViewModel viewModel, Todo todo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Task', style: AppTheme.titleMedium),
          content: Text('Are you sure you want to delete this task?',
              style: AppTheme.bodyMedium),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.deleteTodo(todo.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${todo.title} deleted')),
                );
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  int calculateTaskPoints(Todo todo) {
    // Calculate the difference in days between the target date and today
    final daysUntilTargetDate =
        todo.targetDate.difference(DateTime.now()).inDays;

    // Use if-else structure to assign points based on the days remaining
    if (daysUntilTargetDate < 0) {
      return 0; // No points for overdue tasks
    } else if (daysUntilTargetDate == 0) {
      return 5; // 5 points for tasks due today
    } else if (daysUntilTargetDate < 3) {
      return 15; // 15 points for tasks due within 3 days
    } else if (daysUntilTargetDate < 7) {
      return 20; // 20 points for tasks due within 7 days
    }

    // No points for tasks due later than 7 days
    return 0;
  }
}
