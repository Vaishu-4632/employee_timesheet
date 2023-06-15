import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_timesheet/models/userData.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> profileDetails({
    required String name,
    required int age,
    required String selectGender,
    required String selectDepartment,
    required String imageUrl,
    required String uid,
    required String email,
    required String password,
  }) async {
    String resp = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserData userData = UserData(
            name: name, age: age, selectGender: selectGender, selectDepartment: selectDepartment);
        // UserData userData =UserData(username: username, email: email, password: password, uid: credential.user!.uid);
        await _firestore
            .collection('UserData')
            .doc(credential.user!.uid)
            .set(userData.toJson());
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> registerUser({
    required String fullname,
    required String email,
    required String password,
  }) async {
    String resp = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || fullname.isNotEmpty) {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        resp = "Success";
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}



 // Future<String> UserDetails({
  //   required String fullName,
  //   required String age,
  //   required dynamic selectGender,
  //   required dynamic selectDepartment
  // })async{
  //   String res = "Some error Occured";
  //   try{
  //     if(fullName.isNotEmpty || age.isNotEmpty || selectGender.isNotEmpty || selectDepartment.isNotEmpty){
  //       await _auth.
  //     }
  //   }
  // }

 // Future<UserData> getProfileDetails()async{
  //   User currentUser = _auth.currentUser!;
  //   DocumentSnapshot snap = await _firestore.collection('UserData').doc(currentUser.uid).get();
  //   return UserData.fromSnap(snap);
    
  // }