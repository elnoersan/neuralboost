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

  // Convert Todo object to a Map (for serialization)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'targetDate':
          targetDate.toIso8601String(), // Convert DateTime to ISO 8601 string
      'isCompleted': isCompleted,
    };
  }

  // Create a Todo object from a Map (for deserialization)
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      targetDate: DateTime.parse(
          map['targetDate']), // Convert ISO 8601 string to DateTime
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  // Add the copyWith method
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
