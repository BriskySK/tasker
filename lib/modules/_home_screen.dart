import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tasker/core/ui/app_colors.dart';
import 'package:tasker/database/db.dart';
import 'package:tasker/database/task.dart';
import 'package:tasker/modules/widgets/task_detail.dart';
import 'package:tasker/modules/widgets/task_list.dart';

import '../domain/task_model.dart';

class HomeScreen extends StatefulHookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  late List<Task> tasks;
  Future refresh()async{
    tasks=await TaskDatabase.instance.readAll();
  }
  @override
  void initState(){
    super.initState();
    refresh();
    print(tasks);
  }
  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<TaskModel>> tasks = useState([]);
    ValueNotifier<DateTime?> selectedDate = useState(DateTime.now());
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
                          return TaskDetail(selectedDate, tasks);
                        });
                  },
                  icon: const Icon(Icons.add),
                ),
              )
            ],
          ),
        ),body: TaskList(tasks),
      ),
    );
  }
}
class data extends StatefulWidget {
  const data({Key? key}) : super(key: key);

  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
