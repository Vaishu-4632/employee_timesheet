import 'package:employee_timesheet/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:employee_timesheet/provider/user_provider.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          User? user = userProvider.user;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Name: ${userProvider.nameController}'),
                Text('Age: ${userProvider.ageController}'),
                Text('gender: ${userProvider.selectGender}'),
                Text('gender: ${userProvider.selectDepartment}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
