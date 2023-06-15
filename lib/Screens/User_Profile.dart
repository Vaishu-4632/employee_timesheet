import 'package:employee_timesheet/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:employee_timesheet/provider/user_provider.dart';
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
 


  
  final _formKey = GlobalKey<FormState>();
  String? name;
  int? age;
  String? selectGender;
  String? selectDepartment;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, UserProvider, child) {
          User? user = UserProvider.user;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Name: ${UserProvider.name}'),
                Text('Age: ${UserProvider.age}'),
                Text('gender: ${UserProvider.selectGender}'),
                Text('Department: ${UserProvider.selectDepartment}'),
              ],
            ),
          );
        },
      ),
    );
  }
}



//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Name'),
//               validator: (input) {
//                 if (input!.isEmpty) {
//                   return 'Please enter your name';
//                 }
//                 return null;
//               },
//               onSaved: (input) => name = input,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Age'),
//               validator: (input) {
//                 if (input!.isEmpty) {
//                   return 'Please enter your age';
//                 }
//                 return null;
//               },
//               onSaved: (input) => age = int.parse(input!),
//             ),
//             DropdownButtonFormField(
//               decoration: InputDecoration(labelText: 'Gender'),
//               value: selectGender,
//               items: ['Male', 'Female'].map((gender) {
//                 return DropdownMenuItem(
//                   value: gender,
//                   child: Text('$gender'),
//                 );
//               }).toList(),
//               onChanged: (input) => setState(() => selectGender = input),
//             ),
//             DropdownButtonFormField(
//               decoration: InputDecoration(labelText: 'Gender'),
//               value: selectGender,
//               items: ['Development', 'Management'].map((department) {
//                 return DropdownMenuItem(
//                   value: selectDepartment,
//                   child: Text('$selectDepartment'),
//                 );
//               }).toList(),
//               onChanged: (input) => setState(() => selectDepartment = input),
//             ),
           
//             ElevatedButton(
//               onPressed: submit,
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   submit() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       Provider.of<UserProvider>(context,listen: false).getData(name, age, selectGender, selectDepartment);
//     }
//   }
