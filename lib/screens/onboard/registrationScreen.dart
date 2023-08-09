import 'package:flutter/material.dart';
import 'package:task_manager/data/models/networkResponse.dart';
import 'package:task_manager/data/services/networkCaller.dart';
import 'package:task_manager/data/utility/urls.dart';

import '../../style/style.dart';
import 'loginScreen.dart';

class registrationScreen extends StatefulWidget {
  const registrationScreen({Key? key}) : super(key: key);

  @override
  State<registrationScreen> createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress=false;

  void userSignUp() async {

_signUpInProgress=true;
if (mounted){
  setState(() {

  });
}

    final networkResponse response =
        await NetworkCaller().postRequest(Urls.registration,<String,dynamic> {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text.trim(),
      "mobile":_mobileTEController.text.trim(),
      "password":_passwordTEController.text,
      "photo":""
    });

_signUpInProgress=false;
if (mounted){
  setState(() {

  });
}

    if (response.isSuccess){
      _emailTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileTEController.clear();
      _passwordTEController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Success')));
      }
    }else{
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Failed')));
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
            alignment: Alignment.center,
            child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Join With Us", style: Head1Text(colorDarkBlue)),
                            SizedBox(height: 1),
                            Text("Learn with rabbil hasan", style: Head6Text(colorLightGray)),

                            SizedBox(height: 20),
                            TextFormField(
                              controller: _emailTEController,
                                decoration: AppInputDecoration("Email Address"),
                                onChanged: (Textvalue){
                                },
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
                              controller: _firstNameTEController,
                                decoration: AppInputDecoration("First Name"),
                                onChanged: (Textvalue){
                                },
                              validator:(String?value)
                              {
                                if (value?.isEmpty??true){
                                  return 'Enter your first name';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20),
                            TextFormField(
                              controller: _lastNameTEController,
                                decoration: AppInputDecoration("Last Name"),
                                onChanged: (Textvalue){
                                },
                              validator:(String?value)
                              {
                                if (value?.isEmpty??true){
                                  return 'Enter your last name';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20),
                            TextFormField(
                              controller: _mobileTEController,
                              keyboardType: TextInputType.phone,
                                decoration: AppInputDecoration("Mobile"),
                                onChanged: (Textvalue){
                                },
                              validator:(String?value)
                              {
                                if ((value?.isEmpty??true) || value!.length<11){
                                  return 'Enter your mobile';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordTEController,
                                decoration: AppInputDecoration("Password"),
                                onChanged: (Textvalue){
                                },
                              validator:(String?value)
                              {
                                if ((value?.isEmpty??true) || value!.length<=5){
                                  return 'Enter your password';
                                }
                                return null;
                              },
                            ),


                            // SizedBox(height: 20),
                            // TextFormField(
                            //     decoration: AppInputDecoration("Confirm Password"),
                            //     onChanged: (Textvalue){
                            //     }
                            // ),

                            SizedBox(height: 20),
                            Container(child: Visibility(
                              visible: _signUpInProgress==false,
                              replacement: Center(child: CircularProgressIndicator()),
                              child: ElevatedButton(
                                style: AppButtonStyle(),
                                child: SuccessButtonChild('Registration'),
                                onPressed: (){
                                  if (!_formKey.currentState!.validate()){
                                    return;
                                  }
                                  userSignUp();
                                },
                              ),
                            ),),
                            SizedBox(height: 20),
                            InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => loginScreen()),
                                          (route) => false);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Have an account? ",
                                        style: Head7Text(colorDarkBlue)),
                                    Text(
                                      "Sign In",
                                      style: Head7Text(colorGreen),
                                    )
                                  ],
                                ))

                          ],
                        ),
                      ),
                    )

            ),
          )
        ],
      ),
    );
  }
}
