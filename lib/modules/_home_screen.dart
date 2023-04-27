import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tasker/core/ui/app_colors.dart';
import 'package:tasker/domain/task_model.dart';
import 'package:tasker/modules/widgets/task_detail.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TaskModel> tasks = [];
   // final DateTime todayDate=DateTime.now();/*'${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}'*/;
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

    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
          title: const Center(
              child: Padding(
            padding: EdgeInsets.only(top: 16, left: 64),
            child: Text('Tasker'),
          )),
          backgroundColor: AppColors.secondaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: IconButton(
                onPressed: () async {
                  await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return  TaskDetail(_selectDate,selectedDate.value);
                      });
                },
                icon: const Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
