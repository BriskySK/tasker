import 'package:flutter/material.dart';
import 'package:tasker/core/app_colors.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController=TextEditingController();
    TextEditingController descController=TextEditingController();
    return Container(
      color: AppColors.secondaryColor,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
              color: AppColors.primaryColor,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
                ),
                controller: titleController,
              ),
          ),
const SizedBox(height: 24),
          Container(
            color: AppColors.primaryColor,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
              ),
              controller: descController,
            ),
          ),

        ],
      ),
    );
  }
}
