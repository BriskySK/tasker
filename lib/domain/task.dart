import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.g.dart';

part 'task.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  factory TaskModel({
    required String title,
    required String? description,
    required DateTime? dueDate,
    required bool completed,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, Object?> json)
  => _$TaskModelFromJson(json);
}
// --delete-conflicting-outputs