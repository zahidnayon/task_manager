import 'package:flutter/material.dart';
import 'package:task_manager/screens/onboard/pinVerificationScreen.dart';


import '../../style/style.dart';

class emailVerificationScreen extends StatefulWidget {
  const emailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<emailVerificationScreen> createState() =>
      _emailVerificationScreenState();
}

class _emailVerificationScreenState extends State<emailVerificationScreen> {
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
                  Text("Email Verification", style: Head1Text(colorDarkBlue)),
                  SizedBox(height: 1),
                  Text(
                      "A 6 digit verification pin will send to your email address",
                      style: Head6Text(colorLightGray)),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppInputDecoration("Email Address"),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: ElevatedButton(
                        style: AppButtonStyle(),
                        child: SuccessButtonChild('Send'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      pinVerificationScreen()));
                        },),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
