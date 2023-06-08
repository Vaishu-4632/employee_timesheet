import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserData {
  String? nameController;
  int? ageController;
  String? selectGender;
  String? selectDepartment;

  UserData({this.nameController, this.ageController, this.selectGender, this.selectDepartment});

  Map<String, dynamic> toJson() {
    return {
      'name': nameController,
      'age': ageController,
      'gender': selectGender,
      'department': selectDepartment
    };
  }

  static UserData fromMap(Map<String, dynamic> map) {
    return UserData(
        nameController: map['name'],
        ageController: map['age'],
        selectGender: map['gender'],
        selectDepartment: map['department']);
  }
}

// class UserData {
//   String? imageUrl;
//   String? fullName;
//   String? age;
//   String? gender;
//   String? department;

//   UserData(
//       {this.imageUrl, this.fullName, this.age, this.gender, this.department});

//   Map<String, dynamic> toJson() => {
//         "name": fullName,
//         "age": age,
//         "gender": gender,
//         "department": department,
//         "imageUrl": imageUrl,
//       };
//   UserData fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//     return UserData(
//         fullName: snapshot['fullName'],
//         age: snapshot['age'],
//         gender: snapshot['gender'],
//         department: snapshot['department'],
//         imageUrl: snapshot['imageUrl']);
//   }
// }
