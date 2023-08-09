import 'package:flutter/material.dart';
import 'package:task_manager/data/models/networkResponse.dart';
import 'package:task_manager/data/services/networkCaller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/style/style.dart';



class addNewTaskScreen extends StatefulWidget {
  const addNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<addNewTaskScreen> createState() => _addNewTaskScreenState();
}

class _addNewTaskScreenState extends State<addNewTaskScreen> {

  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();

  bool _addNewTaskInProgress = false;

  Future<void> addNewTask() async{
    _addNewTaskInProgress = true;
    if (mounted){
      setState(() {

      });
    }
    Map <String,dynamic> requestBody = {
      "title":_titleTEController.text.trim(),
      "description":_descriptionTEController.text.trim(),
      "status":"New"
    };
    final networkResponse response = await NetworkCaller().postRequest(
        Urls.createTask, requestBody);
    _addNewTaskInProgress = false;
    if (mounted){
      setState(() {

      });
    }
    if (response.isSuccess){
      _titleTEController.clear();
      _descriptionTEController.clear();
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Task added successful")));
      }
    } else {
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Task added failed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            padding: EdgeInsets.all(30),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add New Task", style: Head1Text(colorDarkBlue)),
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
                      visible: _addNewTaskInProgress == false,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        style: AppButtonStyle(),
                        child: SuccessButtonChild('Submit'),
                        onPressed: () {
                          addNewTask();

                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
