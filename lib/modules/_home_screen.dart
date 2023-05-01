import 'package:flutter/material.dart';
import 'package:tasker/core/ui/app_colors.dart';
import 'package:tasker/database/db_helper.dart';
import 'package:tasker/domain/task.dart';
import 'package:tasker/modules/create_task/create_task.dart';
import 'package:tasker/modules/task_list/task_list.dart';

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
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => CreateTask( ()async{await DbHelper.instance.readAll();})));
                    refresh();
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
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching tasks: ${snapshot.error}'));
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'So far no tasks :)',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                );
              } else {
              return TaskList(tasks);}
            }) /*TaskList(tasks)*/,
      ),
    );
  }
}
