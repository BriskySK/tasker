import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.g.dart';

part 'task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  factory TaskModel({
    required String title,
    required String? description,
    required String? dueDate,
    required bool completed,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, Object?> json)
  => _$TaskModelFromJson(json);
}