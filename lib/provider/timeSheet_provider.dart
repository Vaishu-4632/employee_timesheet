import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TimeSheetProvider extends ChangeNotifier {
  User? user;
  String? selectProject;
  String? date;
  String? totalHours;

  TimeSheetProvider({this.selectProject, this.date, this.totalHours});
  TextEditingController descController = TextEditingController();
  final List<String> project = ['Male', 'Female', 'Other'];
  final List<String> department = ['Development', 'Management', 'CXO'];


  // Store data in Firebase
  Future<void> storeData(name,age,selectGender,selectDepartment) async {
    User user = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('user').doc(user.uid).set({
      'name': name,
      'age': age,
      'gender': selectGender,
      'department': selectDepartment,
    });
    notifyListeners();
  }

  // Retrieve data from Firebase
  // Future<void> getData() async {
  //   User? user = await FirebaseAuth.instance.currentUser;

  //   DocumentSnapshot res = await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(user!.uid)
  //       .get();
  //       if(res.data() != null){
          
  //   Map<String, dynamic> details = res.data() as Map<String, dynamic> ;
  //   print(details);
  //   nameController.text = details['name'];
  //   ageController.text = details['age'];
  //   selectGender = details['gender'];
  //   selectDepartment = details['department'];
  //       }
  //       // print(res);
  //       notifyListeners();
  // }
  Future<void> storeTimesheetData(name,age,selectGender,selectDepartment) async {
    User user = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('user').doc(user.uid).set({
      'name': name,
      'age': age,
      'gender': selectGender,
      'department': selectDepartment,
    });
    notifyListeners();
  }

 
}


