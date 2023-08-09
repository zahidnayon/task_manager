import 'package:flutter/material.dart';
import 'package:task_manager/component/widgets/taskListTile.dart';
import 'package:task_manager/data/models/networkResponse.dart';
import 'package:task_manager/data/models/taskListModel.dart';
import 'package:task_manager/data/services/networkCaller.dart';
import 'package:task_manager/data/utility/urls.dart';
import '../../component/widgets/userProfileBanner.dart';

class progressTaskScreen extends StatefulWidget {
  const progressTaskScreen({Key? key}) : super(key: key);

  @override
  State<progressTaskScreen> createState() => _progressTaskScreenState();
}

class _progressTaskScreenState extends State<progressTaskScreen> {
  bool _getProgressTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  Future<void> getInProgressTasks() async {
    _getProgressTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final networkResponse response =
        await NetworkCaller().getRequest(Urls.inProgressTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('In progress tasks get failed')));
      }
    }

    _getProgressTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getInProgressTasks();
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
              child: _getProgressTasksInProgress
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
