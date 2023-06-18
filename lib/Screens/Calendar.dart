import 'package:employee_timesheet/Screens/add_event.dart';
import 'package:employee_timesheet/Screens/event_editing.dart';
import 'package:employee_timesheet/Widgets/event_item.dart';
import 'package:employee_timesheet/models/event.dart';
import 'package:employee_timesheet/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
   DateTime? _selectedDay;
   CalendarFormat? _calendarFormat;
   Map<DateTime, List<Event>>? _events;
   DateTime? _rangeStart;
  DateTime? _rangeEnd;
   DateTime _focusedDay = DateTime.now();

  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _calendarFormat = CalendarFormat.month;
    // _loadFirestoreEvents();
  }
  
  List<Event>? _getEventsForTheDay(DateTime day) {
    if(_events != null && _events![day] != null){
      return _events![day];
    }else{
      return [];
    }
  }

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
      child: ListView(
        children: [
          TableCalendar(
            
            // eventLoader: _getEventsForTheDay,
            calendarFormat: CalendarFormat.month,
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            headerStyle: const HeaderStyle(
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    formatButtonVisible: false,
                    headerMargin: EdgeInsets.all(16),
                  ),
           calendarStyle: const CalendarStyle(
            cellAlignment: Alignment.center,
                      defaultTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      weekendTextStyle:
                          TextStyle(color: Colors.black, fontSize: 18),
                      cellPadding: EdgeInsets.all(10)),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      weekendStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
            
            headerVisible: true,
            onFormatChanged: (format){
              setState(() {
                _calendarFormat = format;
              });
            },
            focusedDay: DateTime.now(), 
            firstDay: DateTime.utc(2010, 10, 16),
             lastDay: DateTime.utc(2030, 3, 14),
             onPageChanged: (focusedDay){
              _focusedDay = focusedDay;
              // setState(() {
              //   _focusedDay = focusedDay;
              // });
              // _loadFirestoreEvents();
             },
             selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
             onDaySelected: (selectedDay, focusedDay){
              Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => AddEvent(
                firstDate:DateTime.utc(2010, 10, 16),
                lastDate: DateTime.utc(2030, 3, 14),
                selectedDate: _selectedDay,
              ),
            ),
          );
              // print(_events![selectedDay]);
            //   setState(() {
            //     _selectedDay = selectedDay;
            //   });
             },
             ),
        ],
      ),
      
      ),
    );
           
                }
    
  }

//  _loadFirestoreEvents() async {
  //   final firstDay = DateTime(_focusedDay!.year, _focusedDay!.month, 1);
  //   final lastDay = DateTime(_focusedDay!.year, _focusedDay!.month + 1, 0);
  //   _events = {};

  //   final snap = await FirebaseFirestore.instance
  //       .collection('events')
  //       .where('date', isGreaterThanOrEqualTo: firstDay)
  //       .where('date', isLessThanOrEqualTo: lastDay)
  //       .withConverter(
  //           fromFirestore: Event.fromFirestore,
  //           toFirestore: (event, options) => event.toFirestore())
  //       .get();
  //   for (var doc in snap.docs) {
  //     final event = doc.data();
  //     final day =
  //         DateTime.utc(event.date.year, event.date.month, event.date.day);
  //     if (_events![day] == null) {
  //       _events![day] = [];
  //     }
  //     _events![day]!.add(event);
  //   }
  //   setState(() {});
  // }
    // Padding(
      //   padding: EdgeInsets.only(top: 30, left: 18,right: 18 ),
      //   child: 
      //   Column(
      //     children: [
      //       SizedBox(height: 30,),
      //       dropDown(context, 'Select Project', ['Fresher Training','Ygrene','Headway','non-billable','Idle'], Icons.work, selectProject, (newValue){
      //         setState(() {
      //           selectProject = newValue;
      //         });
      //       }),
      //       SizedBox(height: 15,),
      //       dropDown(context, 'Select Approver', ['Sandeep','Chidha'], Icons.person, selectApprover, (newValue){
      //         setState(() {
      //           selectApprover = newValue;
      //         });
      //       }),
      //       SizedBox(height: 50,),
      //       SfCalendar(
              
      //         view: CalendarView.month,
      //         initialSelectedDate: DateTime.now(),
      //         cellBorderColor: Colors.transparent,
      //         todayHighlightColor: Colors.white24,
      //         monthViewSettings: MonthViewSettings(
      //           monthCellStyle: MonthCellStyle(
      //             textStyle: TextStyle(
      //               color: Colors.white,
      //               fontSize: 20
      //             )
      //           )
      //         ),
      //         headerStyle: CalendarHeaderStyle(
      //           textStyle: TextStyle(color: Colors.white54, fontSize: 30,),
      //           textAlign: TextAlign.center,
      
                
      //         ),
      //         viewHeaderStyle: ViewHeaderStyle(
      //           dayTextStyle: TextStyle(color: Colors.white54, fontSize: 20),
                
      //         ),
      //         viewHeaderHeight: 55,
      
      //         // todayTextStyle: TextStyle(fontSize: 20,),
              
      
              
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final result = await Navigator.push<bool>(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => AddEvent(
      //           firstDate:DateTime.utc(2010, 10, 16),
      //           lastDate: DateTime.utc(2030, 3, 14),
      //           selectedDate: _selectedDay,
      //         ),
      //       ),
      //     );
      //     // if (result ?? false) {
      //     //   _loadFirestoreEvents();
      //     // }
      //   },
      //   child: const Icon(Icons.add),
      // ),
       // ... _getEventsForTheDay(_selectedDay!)!.map(
            // (event) => EventItem(
            //     event: event,
            //     onTap: () async {
            //       final res = await Navigator.push<bool>(
            //         context,
            //         MaterialPageRoute(
            //           builder: (_) => EditEvent(
            //               firstDate:DateTime.utc(2010, 10, 16),
            //               lastDate: DateTime.utc(2030, 3, 14),
            //               event: event),
            //         ),
            //       );
                  // if (res ?? false) {
                  //   _loadFirestoreEvents();
                  // }
                // },
                // onDelete: () async {
                //   final delete = await showDialog<bool>(
                //     context: context,
                //     builder: (_) => AlertDialog(
                //       title: const Text("Delete Event?"),
                //       content: const Text("Are you sure you want to delete?"),
                //       actions: [
                //         TextButton(
                //           onPressed: () => Navigator.pop(context, false),
                //           style: TextButton.styleFrom(
                //             foregroundColor: Colors.black,
                //           ),
                //           child: const Text("No"),
                //         ),
                //         TextButton(
                //           onPressed: () => Navigator.pop(context, true),
                //           style: TextButton.styleFrom(
                //             foregroundColor: Colors.red,
                //           ),
                //           child: const Text("Yes"),
                //         ),
                //       ],
                //     ),
                //   );
                  // if (delete ?? false) {
                  //   await FirebaseFirestore.instance
                  //       .collection('events')
                  //       .doc(event.id)
                  //       .delete();
                  //   _loadFirestoreEvents();
                  // }