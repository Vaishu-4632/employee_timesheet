import 'package:employee_timesheet/Screens/HomeScreen.dart';
import 'package:employee_timesheet/Screens/Profile_screen.dart';
import 'package:employee_timesheet/Screens/User_Profile.dart';
import 'package:employee_timesheet/Widgets/reusable_widgets.dart';
import 'package:employee_timesheet/Screens/SignUp.dart';
import 'package:employee_timesheet/Screens/reset_password.dart';
import 'package:employee_timesheet/provider/user_provider.dart';
import 'package:employee_timesheet/resources/auth_method.dart';
import 'package:employee_timesheet/utils/background.dart';
import 'package:employee_timesheet/utils/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isProcessing = true;

  void loginUser() async {
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "Success") {
      User? user = await FirebaseAuth.instance.currentUser;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                top: 150, left: 30, right: 30, bottom: 550),
            child: Column(
              children: <Widget>[
                logoWidget(),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Username or Email", Icons.person_outlined,
                    false, true, false, false, _emailController, "email"),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    false, false, false, _passwordController, "password"),
                const SizedBox(
                  height: 5,
                ),
                forgotPassword(context),
                button(context, "Sign In", () async {
                  User? user = await FireAuth.signInUsingEmailPassword(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            );
                                            print(user);
                                            setState(() {
                                              _isProcessing = false;
                                            });

                                            if (user != null) {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MultiProvider(providers: [
                                                         ChangeNotifierProvider(create: (context) => UserProvider(),)
                                                      ],
                                                      builder: (context, child) => HomeScreen(),
                                                      ),
                                                ),
                                              );
                                            }
              
                }),
                const SizedBox(
                  height: 20,
                ),
                signupOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signupOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "New Here?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignupScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgotPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ResetPassword()));
        },
      ),
    );
  }
}




// Firebase function above widget

 //  Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //   User? user = await FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => ProfileScreen(
            
  //         ),
  //       ),
  //     );
  //   }

  //   return firebaseApp;
  // }

// near submit button

 // User? user = await FireAuth.signInUsingEmailPassword(
                  //                             email: _emailController.text,
                  //                             password:
                  //                                 _passwordController.text,
                  //                           );
                  //                           print(user);
                  //                           setState(() {
                  //                             _isProcessing = false;
                  //                           });

                  //                           if (user != null) {
                  //                             Navigator.of(context)
                  //                                 .pushReplacement(
                  //                               MaterialPageRoute(
                  //                                 builder: (context) =>
                  //                                     ProfileScreen(),
                  //                               ),
                  //                             );
                  //                           }
                  // FirebaseAuth.instance
                  //     .signInWithEmailAndPassword(
                  //         email: _emailController.text,
                  //         password: _passwordController.text)
                  //     .then((value) {
                    
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => ProfileScreen(user: user,)));
                  // }).onError((error, stackTrace) {
                  //   print("Error ${error.toString()}");
                  // });