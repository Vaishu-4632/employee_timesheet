import 'package:employee_timesheet/Screens/Calendar.dart';
import 'package:employee_timesheet/Widgets/reusable_widgets.dart';
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
  String? selectProject;
  String? selectApprover;
  String? selectLocation;
  void initState() {
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 228, 103, 145),
        centerTitle: true,
        title: const Text(
          'Create Task',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            )),
        automaticallyImplyLeading: false,
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
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                dropDown(
                    context,
                    "Project",
                    [
                      "Flutter Training",
                      "Ygrene",
                      "HeadWay",
                      "Abyasa",
                      "Non-Billable",
                      "Idle"
                    ],
                    Icons.work,
                    selectProject, (newValue) {
                  setState(() {
                    selectProject = newValue;
                  });
                }, "Select Project"),
                const SizedBox(
                  height: 20,
                ),
                dropDown(context, "Approver", ["Sandeep", "Chidha"],
                    Icons.person, selectApprover, (newValue) {
                  setState(() {
                    selectApprover = newValue;
                  });
                }, "Select Approver"),
                const SizedBox(
                  height: 20,
                ),
                dropDown(
                    context,
                    "Location",
                    ["Sumeru Office", "Client's Location"],
                    Icons.place,
                    selectLocation, (newValue) {
                  setState(() {
                    selectLocation = newValue;
                  });
                }, "Location"),
                const SizedBox(
                  height: 35,
                ),
                button(context, "Next", () {
                  Navigator.push<bool>(
                    context,
                    MaterialPageRoute(builder: (_) => CalenderScreen()),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context) async {
    DateTime currentTime;
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (pickedTime != null) {
      setState(() {
        currentTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }
}
