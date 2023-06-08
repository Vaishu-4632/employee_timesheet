import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_timesheet/Widgets/reusable_widgets.dart';
import 'package:employee_timesheet/Screens/HomeScreen.dart';
import 'package:employee_timesheet/provider/user_provider.dart';
import 'package:employee_timesheet/utils/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectGender;
  final List<String> gender = ['Male', 'Female', 'Other'];
  String? selectDepartment;
  final List<String> _department = ['Development', 'Management', 'CXO'];
    TextEditingController ageController = TextEditingController();
    TextEditingController nameController = TextEditingController();

  bool _isProcessing = false;
  final _detailFormKey = GlobalKey<FormState>();
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _load = false;
  String? _imageUrl;
  @override
  void initState() {
    storeData();
    getData();
    
    super.initState();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  }
  // updateData() async{
  //   userProvider = Provider.of(context,listen : false);
  //   await userProvider?.refreshUser();
  //  }
  //  Future<UserData> getProfileDetails()async{
  //   User currentUser = _auth.currentUser!;
  //   DocumentSnapshot snap = await _firestore.collection('UserData').doc(currentUser.uid).get();
  //   return UserData.fromSnap(snap);
    
  // }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Profile",
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
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              User? user = userProvider.user;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 100, left: 30, right: 30, bottom: 550),
                  child: Column(
                    children: <Widget>[
                      // logoWidget(),
                      const SizedBox(
                        height: 10,
                      ),
                      profileImage(() {
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()));
                      }),

                      const SizedBox(
                        height: 30,
                      ),

                      Form(
                        key: _detailFormKey,
                        child: Column(
                          children: <Widget>[
                            reusableTextField(
                                "Full Name",
                                Icons.person_outlined,
                                false,
                                false,
                                true,
                                false,
                                nameController,
                                "fullName"),
                            const SizedBox(
                              height: 16,
                            ),
                            reusableTextField(
                                "Age",
                                Icons.person_outlined,
                                false,
                                false,
                                false,
                                true,
                                ageController,
                                "age"),
                            const SizedBox(height: 18.0),
                            dropDown(
                                context,
                                "Gender",
                                gender ,
                                Icons.person_outline,
                                selectGender, (newValue) {
                              setState(() {
                                selectGender = newValue;
                              });
                            }),
                            const SizedBox(
                              height: 16,
                            ),
                            dropDown(context, "Department", _department,
                                Icons.work, selectDepartment, (newValue) {
                              setState(() {
                                selectDepartment = newValue;
                              });
                            }),
                            const SizedBox(height: 24.0),
                            button(context, "Save", () async {
                              storeData();
                              

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                              // print(ref);
                              // }
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
  Future<void> getData() async {
    User? user = await FirebaseAuth.instance.currentUser!;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    Map<String, dynamic> details = doc.data() as Map<String, dynamic>;
    nameController = details['name'];
    ageController = details['age'];
    selectGender = details['gender'];
    selectDepartment = details['department'];
  }
  Future<void> storeData() async {
    User user = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.collection('UserData').doc(user.uid).set({
      'name': nameController,
      'age': ageController,
      'gender': selectGender,
      'department': selectDepartment,
    });
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile!;
      _load = false;
    });
  }

  profileImage(onPressed) {
    return Stack(
      children: [
        _imageUrl == null || _imageUrl!.isEmpty
            ? (_imageFile == null
                ? const CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage(
                      "assets/images/profile.png",
                    ))
                : CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.grey.shade200,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: FileImage(File(_imageFile!.path)),
                    ),
                  ))
            : CircleAvatar(
                radius: 75, backgroundImage: NetworkImage(_imageUrl!)),
        Positioned(
          bottom: 1,
          right: 1,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    50,
                  ),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 4),
                    color: Colors.black.withOpacity(
                      0.3,
                    ),
                    blurRadius: 3,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: InkWell(
                onTap: onPressed,
                child: const Icon(
                  Icons.add_a_photo,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    elevation: 0),
                onPressed: () async {
                  takePhoto(ImageSource.camera);
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference ref = FirebaseStorage.instance.ref();
                  Reference refDirImages = ref.child('profileImages');
                  Reference refImageToUpload =
                      refDirImages.child(uniqueFileName);
                  try {
                    await refImageToUpload.putFile(File(_imageFile!.path));
                    _imageUrl = await refImageToUpload.getDownloadURL();
                  } catch (error) {
                    error.toString();
                  }
                },
                icon: const Icon(Icons.camera, size: 45),
                label: const Text("Camera"),
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image, size: 45),
                  label: const Text("Gallery")),
            ],
          )
        ],
      ),
    );
  }
  
}




 
  // void getProfileDetails() async {
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('UserData').doc(FirebaseAuth.instance.currentUser!.uid).get();
  //   print(snapshot.data());
  //   // CollectionReference profileDetails =
  //   //     FirebaseFirestore.instance.collection('UserData');
  //   // final result = await profileDetails.doc(widget.user.uid).get();
  
  //   // if (result.data() != null) {
      
  //   //   Map<String, dynamic> details = result.data() as Map<String, dynamic>;

  //   //   fullNameController.text = details['name'];
  //   //   _ageController.text = details['age'].toString();
  //   //   _selectGender = details['gender'];
  //   //   _selectDepartment = details['department'];
  //   //   _imageUrl = details['imageLink'];
  //   //   setState(() {
        
  //   //   });
      
  //   }


 // updateData();
                            // getProfileDetails();
                            // if (_detailFormKey.currentState!.validate()) {

                            // _detailFormKey.currentState!.save();
                            // Provider.of<FirebaseStorage>(context).storeData (userProvider.name,userProvider.age,_gender,_department);
                              // User? user = FirebaseAuth.instance.currentUser;
                              // DocumentReference ref = FirebaseFirestore.instance
                              //     .collection('UserData')
                              //     .doc(user!.uid);
                              // await ref.set({
                              //   'name': userProvider!.nameController.text,
                              //   'age': int.parse(ageController.text),
                              //   'gender': _selectGender,
                              //   'department': _selectDepartment,
                              //   'uid': user.uid,
                              //   'imageLink': userProvider!.imageUrl,
                              // });

// submit(){
  //    if (_detailFormKey.currentState!.validate()) {

  //                           _detailFormKey.currentState!.save();
  //                           Provider.of<FirebaseStorage>(context).storeData(fullnameController,ageController,_selectGender,_selectDepartment);
  // }
  // }

  // profileImage(onPressed) {
  //   return Stack(
  //     children: [
  //       _imageUrl == null || _imageUrl!.isEmpty
  //           ? (_imageFile == null ? const CircleAvatar(
  //               radius: 75,
  //               backgroundImage: AssetImage(
  //                 "assets/images/profile.png",
  //               ))
  //           : CircleAvatar(
  //               radius: 75,
  //               backgroundColor: Colors.grey.shade200,
  //               child: CircleAvatar(
  //                 radius: 70,
  //                 backgroundImage: FileImage(File(_imageFile!.path)),
  //               ),
  //             )) : CircleAvatar(
  //               radius:75,
  //               backgroundImage: NetworkImage(_imageUrl!)
  //               ),
  //       Positioned(
  //         bottom: 1,
  //         right: 1,
  //         child: Container(
  //           decoration: BoxDecoration(
  //               border: Border.all(
  //                 width: 3,
  //                 color: Colors.white,
  //               ),
  //               borderRadius: const BorderRadius.all(
  //                 Radius.circular(
  //                   50,
  //                 ),
  //               ),
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(
  //                   offset: const Offset(2, 4),
  //                   color: Colors.black.withOpacity(
  //                     0.3,
  //                   ),
  //                   blurRadius: 3,
  //                 ),
  //               ]),
  //           child: Padding(
  //             padding: const EdgeInsets.all(2.0),
  //             child: InkWell(
  //               onTap: onPressed,
  //               child: const Icon(
  //                 Icons.add_a_photo,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // bottomSheet() {
  //   return Container(
  //     height: 100.0,
  //     width: MediaQuery.of(context).size.width,
  //     margin: const EdgeInsets.all(20),
  //     child: Column(
  //       children: <Widget>[
  //         const Text(
  //           "Choose Profile Photo",
  //           style: TextStyle(fontSize: 20),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: <Widget>[
  //             ElevatedButton.icon(
  //               style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.transparent,
  //                   foregroundColor: Colors.black,
  //                   elevation: 0),
  //               onPressed: () async {
  //                 takePhoto(ImageSource.camera);
  //                 String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  //                 Reference ref = FirebaseStorage.instance.ref();
  //                 Reference refDirImages = ref.child('profileImages');
  //                 Reference refImageToUpload = refDirImages.child(uniqueFileName);
  //                 try{
  //                 await refImageToUpload.putFile(File(_imageFile!.path));
  //                 _imageUrl = await refImageToUpload.getDownloadURL();
  //                 }catch(error){
  //                   error.toString();
  //                 }
  //               },
  //               icon: const Icon(Icons.camera, size: 45),
  //               label: const Text("Camera"),
  //             ),
  //             ElevatedButton.icon(
  //                 style: ElevatedButton.styleFrom(
  //                     backgroundColor: Colors.transparent,
  //                     foregroundColor: Colors.black,
  //                     elevation: 0),
  //                 onPressed: () {
  //                   takePhoto(ImageSource.gallery);
  //                 },
  //                 icon: const Icon(Icons.image, size: 45),
  //                 label: const Text("Gallery")),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
  
    
  