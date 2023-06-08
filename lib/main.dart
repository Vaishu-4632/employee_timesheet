import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_timesheet/Screens/Profile_screen.dart';
import 'package:employee_timesheet/Screens/Sign_in.dart';
import 'package:employee_timesheet/Screens/welcome_screen.dart';
import 'package:employee_timesheet/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
  ),);

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return const WelcomeScreen();
            }else if(snapshot.hasError){
              return Center(
                child: Text('${snapshot.error}'),
              );
            }

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                  child: CircularProgressIndicator()
              );
            }
            return const SigninScreen();
          }
      );
  }
}


