import 'package:employee_timesheet/Widgets/reusable_widgets.dart';
import 'package:employee_timesheet/Screens/HomeScreen.dart';
import 'package:employee_timesheet/Screens/Profile_screen.dart';
import 'package:employee_timesheet/resources/auth_method.dart';
import 'package:employee_timesheet/utils/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Sign_in.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  bool _isProcessing = false;

  @override
  void registerUser() async {
    String res = await AuthMethods().registerUser(
        email: _emailController.text,
        password: _passwordController.text,
        fullname: _fullNameController.text);
    if (res == "Success") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexStringToColor("CB2B93"),
                hexStringToColor("9546C4"),
                hexStringToColor("5E61F4")
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 150, left: 30, right: 30, bottom: 550),
              child: Column(
                children: <Widget>[
                  // logoWidget(),
                  const SizedBox(
                    height: 10,
                  ),

                  reusableTextField("Enter Username", Icons.person_outlined,
                      false, false, true, false, _usernameController, "name"),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Email Id", Icons.email_outlined,
                      false, true, false, false, _emailController, "email"),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_outline, true,
                      false, false, false, _passwordController, "password"),
                  const SizedBox(
                    height: 20,
                  ),
                  button(
                    context,
                    "Sign Up",
                    () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      registerUser();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// inside button
 // setState(() {
                      //   _isProcessing = true;
                      // });
                      // if (_formKey.currentState!.validate()) {
                      //   User? user = await FireAuth.registerUsingEmailPassword(
                      //       fullName: _fullNameController.text,
                      //       username: _emailController.text,
                      //       age: _ageController.text,
                      //       password: _passwordController.text,
                      //       gender: _genderController.text,
                      //       department: _departmentController.text);
                      //   print(user);
                      //   setState(() {
                      //     _isProcessing = false;
                      //   });

                      //   if (user != null) {
                      //     Navigator.of(context).pushAndRemoveUntil(
                      //       MaterialPageRoute(
                      //         builder: (context) => HomeScreen(),
                      //       ),
                      //       ModalRoute.withName('/'),
                      //     );
                      //   }
                      // }



  // FirebaseAuth.instance
                      //     .createUserWithEmailAndPassword(
                      //         email: _emailController.text,
                      //         password: _passwordController.text)
                      //     .then((value) {
                      //   print("Created New Account");
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => HomeScreen(),
                      //     ),
                      //   );
                      // }).onError((error, stackTrace) {
                      //   print("Error ${error.toString()}");
                      // });