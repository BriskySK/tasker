import 'package:flutter/material.dart';
import 'package:tasker/core/ui/app_colors.dart';
import 'package:tasker/database/db_helper.dart';
import 'package:tasker/domain/task.dart';
import 'package:tasker/modules/task_detail/task_detail.dart';

class TaskList extends StatefulWidget {
  List<Task> tasks;

  TaskList(this.tasks, {Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasksList=[];

  @override
  void initState() {
    super.initState();
    tasksList = widget.tasks;
  }

  @override
  void didUpdateWidget(TaskList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tasks != tasksList) {
      setState(() {
        tasksList = widget.tasks;
      });
    }
  }

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
                await DbHelper.instance.delete(widget.tasks[index].id!);
              },
              child: InkWell(
                onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return TaskDetail(taskData: widget.tasks[index]);
                      });
                },
                child: Card(
                  elevation: 8,
                  child: Stack(
                    children: [
                      ListTile(
                        title: Text(
                          widget.tasks[index].title,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        trailing: Checkbox(
                          value: widget.tasks[index].completed,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          onChanged: (bool? value) {
                            setState(() {
                              widget.tasks[index].completed =
                                  !widget.tasks[index].completed ;
                            });
                          },
                        ),
                      ),
                      Positioned.fill(
                        child: AnimatedCrossFade(
                          firstChild: const SizedBox(),
                          secondChild: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.grey.withOpacity(0.5),
                                  Colors.grey.withOpacity(0.5)
                                ],
                              ),
                            ),
                          ),
                          crossFadeState: widget.tasks[index].completed
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 500),
                        ),
                      ),
                    ],
                  ),
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
