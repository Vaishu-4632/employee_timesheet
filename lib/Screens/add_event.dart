import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_timesheet/Screens/Calendar.dart';
import 'package:employee_timesheet/Screens/Calendar_dashboard.dart';
import 'package:employee_timesheet/Widgets/reusable_widgets.dart';
import 'package:employee_timesheet/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  const AddEvent(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      this.selectedDate})
      : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDate;
  final _timeController = TextEditingController();
  final _descController = TextEditingController();
  String? selectProject;
  String? selectApprover;
  String? selectLocation;
  String? selectActivity;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timesheet Efforts'),
        backgroundColor: Colors.purple,
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
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.utc(2010, 10, 16),
                    lastDate: DateTime.utc(2030, 3, 14));
                if (date != null) {
                  _selectedDate = date;
                }
              },
              controller: TextEditingController(
                text: DateFormat('dd MMMM yyyy').format(DateTime.now())
                // _selectedDate.toString(),
              ),
              decoration: InputDecoration(
                labelText: 'Date',
                prefixIcon: const Icon(
                  Icons.calendar_month,
                  color: Colors.white70,
                ),
                labelStyle: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                ),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white.withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            dropDown(
                context,
                "Activity",
                ["Flutter Learning", "Internal Meetings and Discussions"],
                Icons.local_activity,
                selectActivity, (newValue) {
              setState(() {
                selectActivity = newValue;
              });
            }, "Activity"),
            SizedBox(
              height: 25,
            ),
            reusableTextField("Enter Time", Icons.lock_clock_outlined, false,
                false, false, true, _timeController, "time"),
            SizedBox(
              height: 25,
            ),
            TextFormField(
                controller: _descController,
                maxLines: 5,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: true,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                onSaved: (value) => value = value,
                style: TextStyle(color: Colors.white.withOpacity(0.9)),
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                  ),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                ),
                keyboardType: TextInputType.text),
            SizedBox(
              height: 30,
            ),
            button(context, "submit", () {
               _addEvent();
              
            }),
           
          ],
        ),
      ),
    );
  }

  void _addEvent() async {
    final activity  = selectActivity;
    final time = _timeController.text;
    final description = _descController.text;
    if(activity!.isEmpty){
      print('Activity cannot be empty');
      return;
    }
    if (time.isEmpty) {
      print('title cannot be empty');
      return;
    }
    await FirebaseFirestore.instance.collection('events').add({
      "activity": selectActivity,
      "time": time,
      "description": description,
      "date": Timestamp.fromDate(_selectedDate),
    });
    if (mounted) {
      Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CalendarDashboard()),
              );
    }
  }
}
