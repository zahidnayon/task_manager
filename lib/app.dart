import 'package:flutter/material.dart';
import 'package:task_manager/screens/onboard/splashScreen.dart';


class TaskManagerApp extends StatefulWidget {
  static GlobalKey<ScaffoldState> globalKey =GlobalKey<ScaffoldState>();
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: TaskManagerApp.globalKey,
      title: "Task Manager",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark
      ),
      themeMode: ThemeMode.light,
      home:const splashScreen(),
    );
  }
}