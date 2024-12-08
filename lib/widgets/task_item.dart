// lib/widgets/task_item.dart
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String task;
  final Function(bool?) onChanged;
  final bool isCompleted;

  TaskItem(
      {required this.task, required this.onChanged, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(task),
      value: isCompleted,
      onChanged: onChanged,
    );
  }
}
