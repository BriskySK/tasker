import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tasker/core/extentions/date_formater.dart';
import 'package:tasker/core/ui/app_colors.dart';

class TaskDetail extends HookWidget {
  DateTime? currentDate;
  final Function selectDateHandler;

  TaskDetail(this.selectDateHandler, this.currentDate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();

    ValueNotifier<DateTime?> selectedDate= useState(DateTime.now());

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != selectedDate.value) {
        selectedDate.value = picked;
      }
    }
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
                onPressed: ()async{
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate.value!,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != selectedDate.value) {
                    selectedDate.value = picked;
                  }
                },
                child: Text(
                  currentDate != null
                      ? '${currentDate!.day}.${currentDate!.month}.${currentDate!.year}'
                      : DateTime.now().toFormattedString.toString(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TaskTextInput extends StatelessWidget {
  const TaskTextInput({
    super.key,
    required this.widgetController,
    required this.hint,
  });

  final TextEditingController widgetController;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryColor,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        controller: widgetController,
      ),
    );
  }
}
