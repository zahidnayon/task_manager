
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/networkResponse.dart';
import 'package:task_manager/data/models/summaryCountModel.dart';
import 'package:task_manager/data/models/taskListModel.dart';
import 'package:task_manager/data/services/networkCaller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/screens/task/addNewTaskScreen.dart';
import 'package:task_manager/screens/task/updateTaskBottomSheet.dart';
import 'package:task_manager/screens/task/updateTaskStatusSheet.dart';

import '../../component/widgets/summeryCard.dart';
import '../../component/widgets/taskListTile.dart';
import '../../component/widgets/userProfileBanner.dart';

class newTaskScreen extends StatefulWidget {
  const newTaskScreen({Key? key}) : super(key: key);

  @override
  State<newTaskScreen> createState() => _newTaskScreenState();
}

class _newTaskScreenState extends State<newTaskScreen> {
  bool _getCountSummaryInProgress = false,
      _geNewTaskInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TaskListModel _taskListModel = TaskListModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
      getNewTasks();
    });
  }

  Future<void> getNewTasks() async {
    _geNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final networkResponse response =
    await NetworkCaller().getRequest(Urls.newTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context as BuildContext)
            .showSnackBar(SnackBar(content: Text('get new task data failed')));
      }
    }

    _geNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final networkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context as BuildContext)
            .showSnackBar(SnackBar(content: Text('Summary data get failed')));
      }
    }

    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> deleteTask(String taskId) async {
    final networkResponse response = await NetworkCaller().getRequest(
        Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {

        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            userProfileBanner(),
            _getCountSummaryInProgress
                ? LinearProgressIndicator()
                : Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _summaryCountModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return summeryCard(
                      number: _summaryCountModel.data![index].sum ?? 0,
                      title: _summaryCountModel.data![index].sId ?? 'New',
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(height: 4);
                  },
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getNewTasks();
                },
                child: _geNewTaskInProgress
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.separated(
                  itemCount: _taskListModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return taskListTile(
                      data: _taskListModel.data![index],
                      onDeleteTap: () {
                        deleteTask(_taskListModel.data![index].sId!);
                      },
                      onEditTap: () {
                        // showEditBottomSheet(_taskListModel.data![index]);
                        showStatusUpdateBottomSheet(_taskListModel.data![index]);

                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(height: 4);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => addNewTaskScreen()));
        },
      ),
    );
  }

  void showEditBottomSheet(TaskData task) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return UpdateTaskSheet(task: task, onUpdate: () {
            getNewTasks();
          },);
        });
  }

  void showStatusUpdateBottomSheet(TaskData task) {

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return updateTaskStatusSheet(task: task, onUpdate: (){
            getNewTasks();
          });
        },
        );
  }
}



