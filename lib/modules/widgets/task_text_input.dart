import 'package:flutter/material.dart';
import 'package:tasker/core/ui/app_colors.dart';

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