import 'package:tasker/domain/db_model.dart';

class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime dueDate;
  bool completed;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.dueDate,
      required this.completed});

  Map<String, Object?> toJson() => {
        TaskFields.id: id,
        TaskFields.title: title,
        TaskFields.description: description,
        TaskFields.dueDate: dueDate.toIso8601String(),
        TaskFields.completed: completed ? 1 : 0,
      };

  static Task fromJson(Map<String, Object?> json) => Task(
        id: json[TaskFields.id] as int?,
        title: json[TaskFields.title] as String,
        description: json[TaskFields.description] as String,
        dueDate: DateTime.parse(json[TaskFields.dueDate] as String),
        completed: json[TaskFields.completed] == 1,
      );

  Task copy({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? completed,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
        completed: completed ?? this.completed,
      );
}