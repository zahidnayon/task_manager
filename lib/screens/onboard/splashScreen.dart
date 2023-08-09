import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/data/models/authUtility.dart';
import 'package:task_manager/screens/task/appBottomNavScreen.dart';
import 'package:task_manager/style/style.dart';

import 'loginScreen.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  Future<void> navigateToLogin() async {
    Future.delayed(Duration(seconds: 1)).then((_) async {
      final bool isLoggedIn = await authUtility.checkIfUserLoggedIn();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>
          isLoggedIn
              ? const appBottomNavScreen()
              : const loginScreen()),
              (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            padding: EdgeInsets.all(30),
            child: Center(
                child: SvgPicture.asset(
                    "assets/images/logo.svg", alignment: Alignment.center)
            ),
          )
        ],
      ),
    );
  }
}