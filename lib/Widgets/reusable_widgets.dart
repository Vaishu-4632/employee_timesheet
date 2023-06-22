import 'package:employee_timesheet/utils/validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();
bool _isProcessing = true;
var _category = ["Male", "Female", "Other"];
var _department = ["Flutter", "ROR", "HeadWay"];
logoWidget() {

  return 
  Image.asset(
    'assets/images/logo.png',
    color: Colors.white,
    alignment: Alignment.center,
    fit: BoxFit.fitWidth,
    height: 200,
    width: 200,
  );
}

TextFormField reusableTextField(
    String text,
    IconData icon,
    bool isPasswordType,
    bool isEmailType,
    bool isUsernameType,
    bool isAgeType,
    TextEditingController controller,
    String value) {
  return TextFormField(
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) => isPasswordType
        ? Validator.validatePassword(password: value)
        : (isEmailType
            ? Validator.validateEmail(email: value)
            : (isAgeType
                ? Validator.validateAge(age: value)
                : Validator.validateName(name: value)) ) ,
                
    // validator: (value) =>
    //   isPasswordType ? Validator.validatePassword(password: value) : Validator.validateEmail(email: value),
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    textInputAction:
        isPasswordType ? TextInputAction.done : TextInputAction.next,
    onSaved: (value) => value = value,

    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.9),
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
        
  );
}

Widget button(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
    ),
    child: ElevatedButton(
      onPressed: () {
        showLoaderDialog(context);

        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Colors.white;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

dropDown(context, String labelText, List<String> itemsList, IconData icon,
    value, onChanged,hint) {
  return Container(
    child: FormField(
      enabled: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.white70,
            ),
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.white70),
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: Colors.white.withOpacity(0.3),
            contentPadding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(width: 0, style: BorderStyle.none)),
            errorText: field.errorText,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              dropdownColor: Color.fromARGB(255, 69, 36, 75),
              isExpanded: true,
              value: value,
              onChanged: onChanged,
              hint: Text(hint, style: TextStyle( color: Colors.white.withOpacity(0.9),),),
              items: itemsList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    "$option",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              // value: field.value,
            ),
          ),
        );
      },
    ),
  );
}
// profileImage( onPressed){
//   return Stack(
//     children:[
//     CircleAvatar(
//           radius: 75,
//           backgroundColor: Colors.grey.shade200,
//           child: const CircleAvatar(
//             radius: 70,
//             backgroundImage: _imageFile == null ?AssetImage('assets/images/profile.png'),
//           ),
//         ),
//         Positioned(
//           bottom: 1,
//           right: 1,
//           child: Container(
//             decoration: BoxDecoration(
//                 border: Border.all(
//                   width: 3,
//                   color: Colors.white,
//                 ),
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(
//                     50,
//                   ),
//                 ),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     offset: const Offset(2, 4),
//                     color: Colors.black.withOpacity(
//                       0.3,
//                     ),
//                     blurRadius: 3,
//                   ),
//                 ]),
//             child: Padding(
//               padding: EdgeInsets.all(2.0),
//               child: InkWell(
//                 onTap: onPressed,
//                 child: const Icon(Icons.add_a_photo,color: Colors.black,),
//             ),
//           ),
//         ),),
//     ],
//   );
  
// }
//  void getProfileDetails() async {
   
//     CollectionReference profileDetails =
//         FirebaseFirestore.instance.collection('UserData');
//     final result = await profileDetails.doc(widget.user.uid).get();
//     String resp = await StoreData().saveData(file: _imageFile);
  
//     if (result.data() != null) {
      
//       Map<String, dynamic> details = result.data() as Map<String, dynamic>;

//       _fullNameController.text = details['name'];
//       _ageController.text = details['age'].toString();
//       _selectGender = details['gender'];
//       _selectDepartment = details['department'];
//       imageUrl = details['imageLink'];
      
//     }
//   }
  // void selectImage()async{
  //   Uint8List img = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = img;
  //   });
    
  // }
  // void saveImage()async{
  //   String resp = await StoreData().saveData(file: _image!);
  // }
   //  Future<void> _saveProfile() async {
  //   if (_detailFormKey.currentState != null && _detailFormKey.currentState!.validate()) {
  //     _detailFormKey.currentState!.save();
  //     CollectionReference profileDetails =
  //       FirebaseFirestore.instance.collection('UserData');
  //   final result = await profileDetails.doc(widget.user.uid).get();
  //   final details = result.data() as Map<String, dynamic>;
  //     if (result.data() != null) {
      
  //     Map<String, dynamic> details = result.data() as Map<String, dynamic>;

  //     _fullNameController.text = details['name'];
  //     _ageController.text = details['age'].toString();
  //     _selectGender = details['gender'];
  //     _selectDepartment = details['department'];
  //     _imageUrl = details['imageLink'];
      
  //   }
  //     Navigator.pop(context);
  //   }
  // }
