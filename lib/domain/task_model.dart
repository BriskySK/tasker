import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.g.dart';

part 'task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  factory TaskModel({
    required int? id,
    required String title,
    required String? description,
    required DateTime dueDate,
    required bool completed,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, Object?> json) => _$TaskModelFromJson(json);

}
