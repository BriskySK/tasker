import 'package:flutter/material.dart';
import 'package:tasker/core/app_colors.dart';
import 'package:tasker/domain/task_model.dart';
import 'package:tasker/modules/widgets/task_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<TaskModel> tasks = [];
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
                        return TaskDetail();
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
