import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  String? name;
  String? age;
  String? selectGender;
  String? selectDepartment;

  UserProvider({this.name, this.age, this.selectGender, this.selectDepartment});
  TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
  final List<String> gender = ['Male', 'Female', 'Other'];
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
  Future<void> getData() async {
    
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   CollectionReference ref = firestore.collection('user');
    
  //   ref.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  // Map<String, dynamic> details = ref as Map<String, dynamic> ;
  // name = details['name'];
  // age = details['age'];
  // selectGender = details['gender'];
  // selectDepartment = details['department'];
  //       notifyListeners();
  //      });
  //   });
    User? user = await FirebaseAuth.instance.currentUser;

    DocumentSnapshot res = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
        if(res.data() != null){
          
    Map<String, dynamic> details = res.data() as Map<String, dynamic> ;
    print(details);
    nameController.text = details['name'];
    ageController.text = details['age'];
    selectGender = details['gender'];
    selectDepartment = details['department'];
        }
        // print(res);
        notifyListeners();
  }

 
}














// class UserProvider with ChangeNotifier {

//   User? _user;
//   String? _imageUrl;
//   String? _fullName;
//   String? _age;
//   String? _gender;
//   String? _department;

//   User? get user => _user;
//   String? get imageUrl => _imageUrl;
//   String? get fullName => _fullName;
//   String? get age => _age;
//   String? get gender => _gender;
//   String? get department => _department;

  

//   Future<void> saveUserProfile(String gender, String department) async{
//     _imageUrl = imageUrl;
//     _fullName = fullName;
//     _age = age;
//     _gender = gender;
//     _department = department;
//     FirebaseStorage.instance.ref().child('UserData').putData({'imageUrl':imageUrl,'fullName':fullName,'age':age,'gender':gender,'department':department} as Uint8List);
//     notifyListeners();
//   }


//   Future<void> getUserProfile() async{
//     final snapshot = await FirebaseStorage.instance.ref().child('UserData').getData();
//     _imageUrl= snapshot['imageUrl'];
//     _fullName = snapshot['fullName'];
//     _age = snapshot['age'];
//     _gender = snapshot['gender'];
//     _department = snapshot['department'];

//     notifyListeners();
    
//   }  
// }



  
  
  


  // UserData? _user;
  // final AuthMethods _authMethods = AuthMethods();
  // UserData? get getUser => _user;
  // final TextEditingController fullNameController = TextEditingController();
  // final TextEditingController ageController = TextEditingController();
  

  // Future<void> refreshUser() async {
  //   UserData user = await _authMethods.getProfileDetails();
  //   _user = user;
  //   fullNameController.text = user.fullname;
  //   ageController.text = user.age;
  //   selectGender = user.gender;
  //   selectDepartment = user.department;
  //   notifyListeners(); 
  // }
  
  // Future<void> _uploadImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     final file = File(pickedFile.path);
  //     final storageRef = FirebaseStorage.instance.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}');
  //     final uploadTask = storageRef.putFile(file);
  //     final snapshot = await uploadTask.whenComplete(() {});
  //     final downloadUrl = await snapshot.ref.getDownloadURL();
  //     final data = await storageRef.getData();

  //     imageUrl = downloadUrl;
  //     notifyListeners();
  //   }
  // }
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
  //      notifyListeners();
  //   }

//     return firebaseApp;
//   }

// }
