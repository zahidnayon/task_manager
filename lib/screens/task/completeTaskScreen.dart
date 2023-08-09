import 'package:flutter/material.dart';
import 'package:task_manager/component/widgets/taskListTile.dart';
import 'package:task_manager/data/models/networkResponse.dart';
import 'package:task_manager/data/models/taskListModel.dart';
import 'package:task_manager/data/services/networkCaller.dart';
import 'package:task_manager/data/utility/urls.dart';
import '../../component/widgets/userProfileBanner.dart';

class completeTaskScreen extends StatefulWidget {
  const completeTaskScreen({Key? key}) : super(key: key);

  @override
  State<completeTaskScreen> createState() => _completeTaskScreenState();
}

class _completeTaskScreenState extends State<completeTaskScreen> {
  bool _getCompleteTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  Future<void> getInCompleteTasks() async {
    _getCompleteTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final networkResponse response =
        await NetworkCaller().getRequest(Urls.inCompleteTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('In complete tasks get failed')));
      }
    }

    _getCompleteTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getInCompleteTasks();
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
              child: _getCompleteTasksInProgress
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
