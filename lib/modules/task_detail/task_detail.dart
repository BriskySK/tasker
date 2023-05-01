import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasker/core/extentions/date_formater.dart';
import 'package:tasker/core/ui/app_colors.dart';
import 'package:tasker/database/db_helper.dart';
import 'package:tasker/domain/task.dart';
import 'package:tasker/modules/widgets/task_text_input.dart';

class TaskDetail extends StatefulWidget {
  final Task taskData;

  const TaskDetail({required this.taskData, Key? key}) : super(key: key);

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondaryColor,
          ),
          color: AppColors.secondaryColor,
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      height: 250,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isEditing
                    ? Expanded(
                        child: TaskTextInput(
                            widgetController: titleController, hint: widget.taskData.title))
                    : Text(widget.taskData.title, style: Theme.of(context).textTheme.titleSmall),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                    icon: Icon(!isEditing ? Icons.edit : CupertinoIcons.xmark),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Task description: '),
            ),
            isEditing
                ? Expanded(
                    child: TaskTextInput(
                        widgetController: descController, hint: widget.taskData.description))
                : Text(widget.taskData.description),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Due to:'),
                const SizedBox(width: 8),
                Align(
                    alignment: Alignment.center,
                    child: Text(widget.taskData.dueDate.toFormattedString())),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Completed: '),
                    const SizedBox(width: 8),
                    widget.taskData.completed
                        ? const Icon(Icons.check, color: Colors.green)
                        : const Icon(
                            CupertinoIcons.xmark,
                            color: Colors.red,
                          ),
                  ],
                ),
                isEditing?  Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                      child: const Text('save'),
                      onPressed: () async {
                        await DbHelper.instance.edit(Task(
                          id: widget.taskData.id,
                          title: titleController.value.text,
                          description: descController.value.text ,
                          dueDate: widget.taskData.dueDate,
                          completed: widget.taskData.completed,
                        ));
                        Navigator.pop(context);
                      }),
                ):Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
