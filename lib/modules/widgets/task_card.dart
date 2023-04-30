import 'package:flutter/material.dart';
import 'package:tasker/core/ui/app_colors.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final bool isDone;

  TaskCard({
    required this.title,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( 8.0),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.secondaryColor),
              ),
            ),
            const Spacer(),
            Checkbox(
              value: isDone,
              activeColor: Colors.green,
              onChanged: (bool? value) {
                false;
              },
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
