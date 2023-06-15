import 'package:employee_timesheet/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  TextEditingController timeinput = TextEditingController();
  void initState() {
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime;
    String selectTime;
    bool isFinished = false;
    var time = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 228, 103, 145),
        centerTitle: true,
        title: Text(
          'Create Task',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            )),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                size: 30,
              ))
        ],
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextField(
                  controller: timeinput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.timer,
                          color: Colors.white24), //icon of text field
                      labelText: "Check In Time",
                      labelStyle:
                          TextStyle(color: Colors.white) //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      print(pickedTime.format(context)); //output 10:51 PM
                      DateTime parsedTime =
                          DateFormat.jm().parse(pickedTime.format(context));
                      print(parsedTime);
                      String formattedTime =
                          DateFormat('HH:mm').format(parsedTime);
                      print(formattedTime);

                      setState(() {
                        timeinput.text = formattedTime;
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: timeinput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      icon: Icon(Icons.timer,
                          color: Colors.white24), //icon of text field
                      labelText: "Check Out Time",
                      labelStyle:
                          TextStyle(color: Colors.white) //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    //                 TimeOfDay? pickedTime =  await showTimePicker(
                    //     initialTime: TimeOfDay.now(),
                    //     context: context,
                    // );

                    //                 if(pickedTime != null ){
                    // print(pickedTime.format(context));   //output 10:51 PM
                    // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                    // //converting to DateTime so that we can further format on different pattern.
                    // print(parsedTime); //output 1970-01-01 22:53:00.000
                    // String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                    // print(formattedTime); //output 14:59:00
                    // //DateFormat() is from intl package, you can format the time on any pattern you need.

                    // setState(() {
                    //   timeinput.text = formattedTime; //set the value of text field.
                    // });
                    //                 }else{
                    // print("Time is not selected");
                    //                 }
                  },
                ),
              ],
            ),
          ),

          //       TextField(
          //     controller: timeinput, //editing controller of this TextField
          //     decoration: const InputDecoration(
          //        icon: Icon(Icons.timer), //icon of text field
          //        labelText: "Start Time" //label text of field
          //     ),
          //     readOnly: true,  //set it true, so that user will not able to edit text
          //     onTap: () async {
          //       TimeOfDay? pickedTime =  await showTimePicker(
          //             initialTime: TimeOfDay.now(),
          //             context: context,
          //         );

          //       if(pickedTime != null ){
          //         print(pickedTime.format(context));   //output 10:51 PM
          //         DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
          //         //converting to DateTime so that we can further format on different pattern.
          //         print(parsedTime); //output 1970-01-01 22:53:00.000
          //         String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
          //         print(formattedTime); //output 14:59:00
          //         //DateFormat() is from intl package, you can format the time on any pattern you need.

          //         setState(() {
          //           timeinput.text = formattedTime; //set the value of text field.
          //         });
          //       }else{
          //         print("Time is not selected");
          //       }
          //     },
          //  )
        ),
      ),
    );
  }
  Future<Null> _selectTime(BuildContext context) async {
     DateTime currentTime;
    final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if(pickedTime != null){
      setState(() {
        currentTime = DateTime(DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
        );
      });
    }
  }
}
// child: Padding(
// padding: const EdgeInsets.only(
//     top: 50, left: 30, right: 30, bottom: 550),
// child: Padding(
//   padding: const EdgeInsets.only(left: 20, right: 20),
//   child: Column(
//     children: <Widget>[
//       const SizedBox(
//         height: 30,
//       ),
//       Container(
//         alignment: Alignment.centerLeft,
//         margin: const EdgeInsets.only(top: 30),
//         child: const Text(
//           "Welcome",
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.w600,
//             color: Colors.white38,
//           ),
//         ),
//       ),

//       Container(
//         alignment: Alignment.centerLeft,
//         child: const Text(
//           "Employee",
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.w700,
//             color: Colors.white70,
//           ),
//         ),
//       ),

//       Container(
//         alignment: Alignment.centerLeft,
//         margin: const EdgeInsets.only(top: 32),
//         child: const Text(
//           "Today's Status",
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       const SizedBox(
//         height: 8,
//       ),

//       // SizedBox(height: 6 ,),
//       Container(
//         height: 150,
//         margin: const EdgeInsets.only(top: 12),
//         decoration: const BoxDecoration(
//             color: Color.fromARGB(255, 215, 171, 223),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black,
//                 blurRadius: 40,
//                 offset: Offset(3, 3),
//               ),
//             ],
//             borderRadius: BorderRadius.all(Radius.circular(20))),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: const [
//                   Text(
//                     'Check In',
//                     style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 25,
//                         color: Colors.white70),
//                   ),
//                   Text(
//                     "10:00",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 23,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: const [
//                   Text(
//                     'Check Out',
//                     style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 25,
//                         color: Colors.white60),
//                   ),
//                   Text(
//                     "7:00",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 23,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(
//         height: 30,
//       ),
//       Container(
//         alignment: Alignment.centerLeft,
//         child: Text(
//           '${DateFormat('MMMMEEEEd').format(time)}',
//           style: const TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.w800,
//               color: Colors.white),
//           textAlign: TextAlign.center,
//         ),
//       ),
//       SizedBox(
//         height: 8,
//       ),
//       Container(
//         alignment: Alignment.centerLeft,
//         child: Text(
//           '${DateFormat('Hm').format(time)}',
//           style: const TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.w800,
//               color: Colors.white),
//           textAlign: TextAlign.center,
//         ),
//       ),
//       SizedBox(
//         height: 30,
//       ),

//       // Builder(builder: (context){
//       //   final GlobalKey<SlideActionState> key = GlobalKey();
//       //   return SlidableAction(onPressed: (){})
//       // }

//       // )

//       // Container(
//       //   child: SwipeableButtonView(
//       //     buttonText: "SLIDE TO CHECK-IN",
//       //     buttonWidget: const Icon(
//       //       Icons.arrow_forward_ios_rounded,
//       //       color: Colors.grey,
//       //     ),
//       //     activeColor: Colors.blue,
//       //      isFinished: isFinished,
//       //     onFinish: () {
//       //       SwipeableButtonView(
//       //         buttonText: "SLIDE TO CHECK-OUT",
//       //         buttonWidget: const Icon(
//       //           Icons.arrow_forward_ios_rounded,
//       //           color: Colors.grey,
//       //         ),
//       //         activeColor: Colors.blue,
//       //         onFinish: () {},
//       //         onWaitingProcess: () {},
//       //       );
//       //     },
//       //     onWaitingProcess: () {
//       //       Future.delayed(Duration(seconds: 0), () {
//       //       setState(() {
//       //         isFinished = true;
//       //       });
//       //     });

//       //     },
//       //   ),

//     ],
//   ),
// ),
