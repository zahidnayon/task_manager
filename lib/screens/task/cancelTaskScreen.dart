import 'package:flutter/material.dart';
import 'package:task_manager/data/models/networkResponse.dart';
import 'package:task_manager/data/models/taskListModel.dart';
import 'package:task_manager/data/services/networkCaller.dart';
import 'package:task_manager/data/utility/urls.dart';

import '../../component/widgets/taskListTile.dart';
import '../../component/widgets/userProfileBanner.dart';

class cancelTaskScreen extends StatefulWidget {
  const cancelTaskScreen({Key? key}) : super(key: key);

  @override
  State<cancelTaskScreen> createState() => _cancelTaskScreenState();
}

class _cancelTaskScreenState extends State<cancelTaskScreen> {

  bool _getCancelTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  Future<void> getInCancelTasks() async {
    _getCancelTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final networkResponse response =
    await NetworkCaller().getRequest(Urls.inCancelTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('In cancel tasks get failed')));
      }
    }

    _getCancelTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getInCancelTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            userProfileBanner(),
            Expanded(
              child: _getCancelTasksInProgress
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.separated(
                itemCount: _taskListModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                        return taskListTile(
                          data: _taskListModel.data![index],
                          onDeleteTap: () {},
                          onEditTap: () {},
                        );
                      },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 4);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
