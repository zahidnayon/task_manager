import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/screens/onboard/setPasswordScreen.dart';

import '../../style/style.dart';
import 'loginScreen.dart';

class pinVerificationScreen extends StatefulWidget {
  const pinVerificationScreen({Key? key}) : super(key: key);

  @override
  State<pinVerificationScreen> createState() => _pinVerificationScreenState();
}

class _pinVerificationScreenState extends State<pinVerificationScreen> {
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
                  PinCodeTextField(
                      appContext: context,
                      length: 6,
                      pinTheme: AppOTPStyle(),
                      animationType: AnimationType.fade,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) {

                      },
                      onChanged: (value) {
                      }
                  ),
                  Container(child: ElevatedButton(
                    style: AppButtonStyle(),
                    child: SuccessButtonChild('Verify'),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => setPasswordScreen()),
                              (route) => false);
                    },
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
      ),
        ],
      ),
    );
  }
}
