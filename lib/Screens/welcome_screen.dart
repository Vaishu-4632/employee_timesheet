import 'package:employee_timesheet/Widgets/reusable_widgets.dart';
import 'package:employee_timesheet/Screens/SignUp.dart';
import 'package:employee_timesheet/Screens/Sign_in.dart';
import 'package:employee_timesheet/utils/background.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
  
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(
      body: Container(
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
                top: 150, left: 80, right: 80, bottom: 550),
            child: Column(
              children: <Widget>[
                logoWidget(),
                const SizedBox(
                  height: 60,
                ),
                button(context, "Log In", (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SigninScreen()));
                }),
                button(context, "Register", (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()));
                }),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}