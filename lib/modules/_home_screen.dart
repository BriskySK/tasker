import 'package:flutter/material.dart';
import 'package:tasker/core/ui/app_colors.dart';
import 'package:tasker/database/db_helper.dart';
import 'package:tasker/domain/task.dart';
import 'package:tasker/modules/widgets/task_detail.dart';
import 'package:tasker/modules/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refresh();
    print(tasks);
  }

  @override
  void dispose() {
    DbHelper.instance.close();
    super.dispose();
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    tasks = await DbHelper.instance.readAll();
    for(var task in tasks){
    print(task.title);}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: ()  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskDetail(tasks)));
                  },
                  icon: const Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
        body: FutureBuilder(
            future: DbHelper.instance.readAll(),
            builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                const Text(
                  'No task to display',
                  style: TextStyle(color: Colors.black),
                );
              }
              return TaskList(tasks);
            }) /*TaskList(tasks)*/,
      ),
    );
  }
}
