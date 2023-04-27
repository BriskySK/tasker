import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tasker/core/extentions/date_formater.dart';
import 'package:tasker/core/ui/app_colors.dart';
import 'package:tasker/domain/task_model.dart';
import 'package:tasker/modules/widgets/task_text_input.dart';

class TaskDetail extends HookWidget {
  ValueNotifier<DateTime?> currentDate;
  ValueNotifier<List<TaskModel>> tasks;

  TaskDetail(this.currentDate, this.tasks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    ValueNotifier<DateTime?> selectedDate = useState(DateTime.now());

    return Container(
      color: AppColors.secondaryColor,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Center(
              child: Text(
            'Create a task',
            style: Theme.of(context).textTheme.titleMedium,
          )),
          TaskTextInput(widgetController: titleController, hint: 'Title'),
          const SizedBox(height: 24),
          TaskTextInput(widgetController: descController, hint: 'Description'),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                'Due to: ',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(AppColors.tertiaryColor)),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate.value!,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppColors.secondaryColor,
                            onPrimary: AppColors.primaryColor,
                            onSurface: AppColors.secondaryColor,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null && picked != selectedDate.value) {
                    selectedDate.value = picked;
                  }
                },
                child: Text(
                  selectedDate.value != null
                      ? '${selectedDate.value!.day}.${selectedDate.value!.month}.${selectedDate.value!.year}'
                      : DateTime.now().toFormattedString.toString(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if(tasks.value.isEmpty){
                tasks.value.add(TaskModel(title:titleController.text, description: descController.text, dueDate: selectedDate.value?.toFormattedString.toString(), completed: false));
              }
              print(tasks.value);

            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }
}
