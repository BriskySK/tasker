import 'package:flutter/material.dart';
import 'package:tasker/core/ui/app_colors.dart';
import 'package:tasker/database/db_helper.dart';
import 'package:tasker/domain/task.dart';

class TaskList extends StatefulWidget {
  List<Task> tasks;

  TaskList(this.tasks, {Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    if (widget.tasks.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Dismissible(
              key: ValueKey<Task>(widget.tasks[index]),
              background: Container(
                color: AppColors.errorColor,
              ),
              onDismissed: (DismissDirection direction) async {
                await DbHelper.instance.delete(index);
              },
              child: Card(
                elevation: 8,
                child: ListTile(
                  title: Text(
                    widget.tasks[index].title,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  trailing: Checkbox(
                      value: widget.tasks[index].completed,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      onChanged: (bool? value) {
                        setState(() {
                          widget.tasks[index].completed = !widget.tasks[index].completed;
                        });
                      }),
                ),
              ),
            ),
          );
        },
      );
    }

    return Center(
      child: Text(
        'So far no tasks :)',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.secondaryColor),
      ),
    );
  }
}
