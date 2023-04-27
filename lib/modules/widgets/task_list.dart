import 'package:flutter/material.dart';
import 'package:tasker/core/ui/app_colors.dart';
import 'package:tasker/domain/task_model.dart';
import 'package:tasker/modules/widgets/task_card.dart';

class TaskList extends StatelessWidget {
  ValueNotifier<List<TaskModel>> tasks;

  TaskList(this.tasks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tasks.value.isNotEmpty) {
      for (var task in tasks.value) {
        return TaskCard(title: task.title,isDone:task.completed);
      }
    }
    return Center(
        child: Text(
      'So far no tasks :)',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.secondaryColor),
    ));
  }
}
