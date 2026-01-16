// Model: Represents the data structure for a to-do item
class Todo {
  final String id;
  final String title;
  final String description;
  final DateTime targetDate;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.targetDate,
    this.isCompleted = false,
  });

  // Helper method to create a copy of the Todo with updated fields
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? targetDate,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      targetDate: targetDate ?? this.targetDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
