import 'package:employee_timesheet/Screens/Calendar.dart';
import 'package:employee_timesheet/Screens/Profile_screen.dart';
import 'package:employee_timesheet/Screens/TodayScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<IconData> navigationIcons =[
    Icons.check,
    Icons.calendar_month,
    Icons.person
  ];
  @override
  Widget build(BuildContext context) {
    
   
    return Scaffold(
      
      body: 
      IndexedStack(
        index: currentIndex,
        children: [
          TodayScreen(),
          CalenderScreen(),
          ProfileScreen(),
        ],
      ),
        bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 215, 171, 223),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 20,
              offset: Offset(2, 2)
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i = 0; i < navigationIcons.length;i++)...<Expanded>{
              Expanded(
                child: 
                GestureDetector(
                  onTap: (){
                    setState(() {
                      currentIndex = i;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                      child: Icon(navigationIcons[i],
                      color: i == currentIndex ? Colors.white : Colors.black,
                      size: i == currentIndex ? 35 : 30,
                      ),
                      
                                  ),
                    ],
                  ),
                ),),}
            ],
          ),
        ) ,
      ),
        
      );
    
  }
}
