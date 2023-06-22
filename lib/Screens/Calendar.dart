import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_timesheet/Widgets/reusable_widgets.dart';
import 'package:employee_timesheet/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateTime? _selectedDay;
  Duration _totalDuration = Duration.zero;
  // Map<DateTime, List<Event>>? _events;
  List _dailyActivities = [];
  final TextEditingController _timeSpentController = TextEditingController();
  final _descController = TextEditingController();
  late final CalendarController _calendarController;
  String? _selectedActivityType;

  Future _fetchDailyActivities() async {
    final activities = await FirebaseFirestore.instance
        .collection('events')
        .where("date", isEqualTo: Timestamp.fromDate(_selectedDay!.toUtc()))
        .get();

    setState(() {
      _dailyActivities =
          activities.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
           _totalDuration = _calculateTotalDuration(_dailyActivities);
    });
  }
  Duration _calculateTotalDuration(List activities) {
  int totalMinutes = 0;
  for (Map activity in activities) {
    totalMinutes += int.parse(activity['time']);
  }
  return Duration(minutes: totalMinutes);
}

  void _addEvent() async {
    final activity = _selectedActivityType;
    final time = _timeSpentController.text;
    final description = _descController.text;
    if (activity!.isEmpty) {
      print('Activity cannot be empty');
      return;
    }
    if (time.isEmpty) {
      print('title cannot be empty');
      return;
    }
    await FirebaseFirestore.instance.collection('events').add({
      "activity": _selectedActivityType,
      "time": time,
      "description": description,
      "date": Timestamp.fromDate(_selectedDay!),
    });
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Widget _buildDailyActivityListItem(Map activity) {
    return ListTile(
      title: Text(activity['name']),
      subtitle: Text('${activity['time']} hours'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            _dailyActivities.remove(activity);
          });
        },
      ),
    );
  }

  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _fetchDailyActivities();
    _calendarController = CalendarController();
  }

  void _previousWeek() {
    setState(() {
      _selectedDay = _selectedDay!.subtract(Duration(days: 7));
    });
  }

  void _nextWeek() {
    setState(() {
      _selectedDay = _selectedDay!.add(Duration(days: 7));
    });
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
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: _previousWeek,
                ),
                Text(
                  DateFormat.yMMMM().format(_selectedDay!),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: _nextWeek,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    7,
                    (index) {
                      final date = _selectedDay!.add(
                          Duration(days: index - _selectedDay!.weekday + 1));
                      final textStyle = TextStyle(
                        fontWeight: _selectedDay!.weekday == index + 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: Colors.white,
                        fontSize: 13,
                      );
                      final today = DateTime.now();
                      final isToday = (date.day == today.day &&
                          date.month == today.month &&
                          date.year == today.year);
                      final borderColor =
                          isToday ? Colors.white : Colors.transparent;

                      final textColor = isToday ? Colors.white : Colors.white;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDay = date;
                            _fetchDailyActivities();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: borderColor,
                                // _selectedDay!.weekday == index+1 ? Colors.white : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat.E().format(date).toUpperCase(),
                                style: textStyle.copyWith(color: textColor),
                              ),
                              Text(
                                DateFormat.d().format(date),
                                style: textStyle.copyWith(color: textColor),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _dailyActivities.length + 1,
                itemBuilder: (context, index) {
                  if(index == 0){
                    return Container(
          height: 50,
          color: Colors.white10,
          child: Center(
            child: Text(
              'Total Duration: ${_totalDuration.inMinutes} hours ',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
                  }else{
                  final activity = _dailyActivities[index-1];
                  return Container(
                    height: 85,
                    color: Colors.white10,
                    child: ListTile(
                      title: Text(
                        activity['activity'],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${activity['time']} hours',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('events')
                              .doc(activity['id'])
                              .delete();
                          setState(() {
                            _dailyActivities.removeAt(index-1);
                              _totalDuration = _calculateTotalDuration(_dailyActivities);
                          });
                        },
                      ),
                    ),
                  );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.purple,
                    title: Text(
                      'Add Activity',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        dropDown(
                            context,
                            'Activity',
                            [
                              'Flutter Learning',
                              'Internal Meetings & Sessions'
                            ],
                            Icons.local_activity_outlined,
                            _selectedActivityType, (value) {
                          setState(() {
                            _selectedActivityType = value;
                          });
                        }, 'Select Activity'),
                        SizedBox(
                          height: 15,
                        ),
                        reusableTextField('Time Spent', Icons.lock_clock, false,
                            false, false, true, _timeSpentController, 'time'),
                        SizedBox(
                          height: 15,
                        ),
                        reusableTextField(
                            'Description',
                            Icons.description,
                            false,
                            false,
                            true,
                            false,
                            _descController,
                            'description')
                      ],
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: button(context, 'Save', () {
                          _addEvent();
                          Navigator.pop(context);
                        }),
                      )
                    ],
                  ));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

 