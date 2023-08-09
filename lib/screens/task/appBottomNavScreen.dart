

import 'package:flutter/material.dart';
import 'package:task_manager/screens/task/cancelTaskScreen.dart';
import 'package:task_manager/screens/task/completeTaskScreen.dart';
import 'package:task_manager/screens/task/progressTaskScreen.dart';

import '../../style/style.dart';
import 'newTaskScreen.dart';

class appBottomNavScreen extends StatefulWidget {
  const appBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<appBottomNavScreen> createState() => _appBottomNavScreenState();
}

class _appBottomNavScreenState extends State<appBottomNavScreen> {

  int _seletedScreenIndex=0;

  final List<Widget> _screens=const [
    newTaskScreen(),
    progressTaskScreen(),
    completeTaskScreen(),
    cancelTaskScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: _screens[_seletedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: "New"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time_rounded),
              label: "Progress"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outlined),
              label: "Completed"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_outlined),
              label: "Canceled"
          )
        ],
        onTap: (int index){
          _seletedScreenIndex=index;
          if(mounted){
            setState(() {

            });
          }
        },
        selectedItemColor: colorGreen,
        unselectedItemColor: colorLightGray,
        currentIndex: _seletedScreenIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
