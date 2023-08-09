import 'package:flutter/material.dart';
import 'package:task_manager/data/models/authUtility.dart';
import 'package:task_manager/data/models/loginModel.dart';
import 'package:task_manager/data/models/networkResponse.dart';
import 'package:task_manager/data/services/networkCaller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/screens/task/appBottomNavScreen.dart';
import 'package:task_manager/screens/onboard/registrationScreen.dart';
import 'package:task_manager/style/style.dart';

import 'emailVerificationScreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();

  bool _logInProgress  =false;

  Future<void> login() async{
    _logInProgress=true;
    if (mounted){
      setState(() {

      });
    }
    Map <String,dynamic> requestBody={
      "email":_emailTEController.text.trim(),
      "password":_passwordTEController.text,
    };
    final networkResponse response = await NetworkCaller().postRequest(
        Urls.login, requestBody, islogin : true);
    _logInProgress=false;
    if (mounted){
      setState(() {

      });
    }
    if (response.isSuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await authUtility.saveUserInfo(model);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => appBottomNavScreen()),
                (route) => false);
      }
    }else{
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Incorrect email and password')));
      }
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Get Started With", style: Head1Text(colorDarkBlue)),
                    SizedBox(height: 1),
                    Text("Learn with rabbil hasan",
                        style: Head6Text(colorLightGray)),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppInputDecoration("Email Address"),
                      validator:(String?value)
                      {
                        if (value?.isEmpty??true){
                          return 'Enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: AppInputDecoration("Password"),
                      validator:(String?value)
                      {
                        if ((value?.isEmpty??true) || value!.length<=5){
                          return 'Enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Visibility(
                        visible: _logInProgress==false,
                        replacement: Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(
                          style: AppButtonStyle(),
                          child: SuccessButtonChild('Login'),
                          onPressed: (){
                            login();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            emailVerificationScreen()));
                              },
                              child: Text(
                                'Forget Password?',
                                style: Head7Text(colorLightGray),
                              )),
                          SizedBox(height: 15),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            registrationScreen()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account? ",
                                      style: Head7Text(colorDarkBlue)),
                                  Text(
                                    "Sign Up",
                                    style: Head7Text(colorGreen),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
