import 'package:flutter/material.dart';
import 'package:task_manager/data/models/networkResponse.dart';
import 'package:task_manager/data/models/taskListModel.dart';
import 'package:task_manager/data/services/networkCaller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/style/style.dart';

class UpdateTaskSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskSheet(
      {super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskSheet> createState() => _UpdateTaskSheetState();
}

class _UpdateTaskSheetState extends State<UpdateTaskSheet> {
  late TextEditingController _titleTEController;

  late TextEditingController _descriptionTEController;

  bool _updateTaskInProgress = false;

  @override
  void initState() {
    TextEditingController(text: widget.task.title);
    TextEditingController(text: widget.task.description);
    super.initState();
  }

  Future<void> updateTasks() async{
    _updateTaskInProgress = true;
    if (mounted){
      setState(() {

      });
    }
    Map <String,dynamic> requestBody = {
      "title":_titleTEController.text.trim(),
      "description":_descriptionTEController.text.trim(),
    };
    final networkResponse response = await NetworkCaller().postRequest(
        Urls.createTask, requestBody);
    _updateTaskInProgress = false;
    if (mounted){
      setState(() {

      });
    }
    if (response.isSuccess){
      _titleTEController.clear();
      _descriptionTEController.clear();
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Task updated successful")));
      }
      widget.onUpdate();
    } else {
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Task added failed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Update Task", style: Head1Text(colorDarkBlue)),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _titleTEController,
              keyboardType: TextInputType.emailAddress,
              decoration: AppInputDecoration("Title"),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _descriptionTEController,
              decoration: AppInputDecoration("Description"),
            ),
            SizedBox(height: 20),
            Container(
              child: Visibility(
                visible: _updateTaskInProgress == false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                  style: AppButtonStyle(),
                  child: SuccessButtonChild('Update'),
                  onPressed: () {
                    updateTasks();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
