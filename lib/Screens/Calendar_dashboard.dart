import 'dart:math';

import 'package:employee_timesheet/Screens/Calendar.dart';
import 'package:employee_timesheet/Screens/Sign_in.dart';
import 'package:employee_timesheet/Widgets/reusable_widgets.dart';
import 'package:employee_timesheet/utils/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CalendarDashboard extends StatefulWidget {
  const CalendarDashboard({super.key});

  @override
  State<CalendarDashboard> createState() => _CalendarDashboardState();
}

class _CalendarDashboardState extends State<CalendarDashboard> {
  User? _currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.only(left:20.0, right: 20,top: 80),
          child: Column(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(top: 50, left: 25, right: 15),
                Table(
                  border: TableBorder.all(width: 1, color: Colors.white),
                   columnWidths: const {
                0: FixedColumnWidth(100),
                1: FlexColumnWidth(100),
                2: FlexColumnWidth(130)
              },
                  children: const [
                    TableRow(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        children: [
                           TableCell(
                            child: 
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                          TableCell(
                            child: 
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Project',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Total Hours',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        ]),
                    TableRow(children: [
                      TableCell(
                        child: Padding(padding: EdgeInsets.all(20),child: Text('Mon,12th Jun 23',style: TextStyle(
                                    color: Colors.white,
                                    
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.
                                    center,
                                textScaleFactor: 1.5,)),),
                      TableCell(
                        child: Padding(padding: EdgeInsets.all(20),child: Text('Flutter Learning',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                textScaleFactor: 1.5,)),),
                      TableCell(child:
                       Padding(padding: EdgeInsets.all(20),
                      child: Text('08',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.5,),))
                    ],),
                    TableRow(children: [
                      TableCell(
                        child: Padding(padding: EdgeInsets.all(20),child: Text('Tue,13th Jun 23',style: TextStyle(
                                    color: Colors.white,
                                    
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.
                                    center,
                                textScaleFactor: 1.5,)),),
                      TableCell(
                        child: Padding(padding: EdgeInsets.all(20),child: Text('Flutter Learning',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                textScaleFactor: 1.5,)),),
                      TableCell(child:
                       Padding(padding: EdgeInsets.all(20),
                      child: Text('08',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.5,),))
                    ],),
                    TableRow(children: [
                      TableCell(
                        child: Padding(padding: EdgeInsets.all(20),child: Text('Wed,14th Jun 23',style: TextStyle(
                                    color: Colors.white,
                                    
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.
                                    center,
                                textScaleFactor: 1.5,)),),
                      TableCell(
                        child: Padding(padding: EdgeInsets.all(20),child: Text('Flutter Learning',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                textScaleFactor: 1.5,)),),
                      TableCell(child:
                       Padding(padding: EdgeInsets.all(20),
                      child: Text('08',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.5,),))
                    ],),
                    TableRow(children: [
                      TableCell(
                        child: Padding(padding: EdgeInsets.all(20),child: Text('Thur,15th Jun 23',style: TextStyle(
                                    color: Colors.white,
                                    
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.
                                    center,
                                textScaleFactor: 1.5,)),),
                      TableCell(
                        child: Padding(padding: EdgeInsets.all(20),child: Text('Flutter Learning',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                textScaleFactor: 1.5,)),),
                      TableCell(child:
                       Padding(padding: EdgeInsets.all(20),
                      child: Text('08',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.5,),))
                    ],),
                    TableRow(children: [
                      TableCell(
                        child: Padding(padding: EdgeInsets.all(20),child: Text('Fri,16th Jun 23',style: TextStyle(
                                    color: Colors.white,
                                    
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.
                                    center,
                                textScaleFactor: 1.5,)),),
                      TableCell(
                        child: Padding(padding: EdgeInsets.all(20),child: Text('Flutter Learning',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                textScaleFactor: 1.5,)),),
                      TableCell(child:
                       Padding(padding: EdgeInsets.all(20),
                      child: Text('08',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.5,),))
                    ],),
                  ],
                ),
                SizedBox(height: 20,),
              
              button(context, "Log Out", (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SigninScreen()),);
              },
              
              ),
            button(context, "Go To Home", (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CalenderScreen()),
              );
            }
            )
            ],
          ),
        ),
      ),
    );
  }
}
