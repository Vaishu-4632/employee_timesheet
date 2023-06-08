import 'package:employee_timesheet/Widgets/reusable_widgets.dart';
import 'package:employee_timesheet/Screens/Sign_in.dart';
import 'package:employee_timesheet/utils/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
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

                reusableTextField("Enter Email Id", Icons.email_outlined, false,true,true,false,
                    _emailController, "email"),

                const SizedBox(
                  height: 20,
                ),
                button(context, "Reset Password", (){
                  FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text).then((value) {
                    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SigninScreen()));
                  });

                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
