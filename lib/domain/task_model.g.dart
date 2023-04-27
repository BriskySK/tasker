// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskModel _$$_TaskModelFromJson(Map<String, dynamic> json) => _$_TaskModel(
      title: json['title'] as String,
      description: json['description'] as String?,
      dueDate: json['dueDate'] as String?,
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$$_TaskModelToJson(_$_TaskModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate,
      'completed': instance.completed,
    };
