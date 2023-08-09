import 'package:flutter/material.dart';
import 'package:task_manager/component/widgets/userProfileBanner.dart';
import 'package:task_manager/style/style.dart';

class updateProfileScreen extends StatefulWidget {
  const updateProfileScreen({Key? key}) : super(key: key);

  @override
  State<updateProfileScreen> createState() => _updateProfileScreenState();
}

class _updateProfileScreenState extends State<updateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              userProfileBanner(
                isUpdateScreen: true,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Update Profile"),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      width:double.infinity,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.0),
                            color: Colors.grey,
                            child: Text('Photos'),
                          )
                        ],
                      ),
                    ),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                    child: ElevatedButton(onPressed: (){}, child: Text('Update'),
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
