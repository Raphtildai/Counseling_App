// import 'package:careapp/functionalities/calendar/approved_Dates_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

List<DateTime> datescalendar = [];

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    getapprovedDocIDs();
    getAppointments(datescalendar);
    MeetingDataSource(<Appointment>[]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counselor\'s Schedule'),
        centerTitle: true,
      ),
      body: SfCalendar(
        minDate: DateTime.now(),
        maxDate: DateTime(2023),
        view: CalendarView.week,
        firstDayOfWeek: 1,
        cellBorderColor: Colors.deepPurple[100],
        dataSource: MeetingDataSource(getAppointments(datescalendar)),
      ),
    );
  }
}

Future trySomething() async {
  var userid = FirebaseAuth.instance.currentUser!.uid;

  var coll2 =
      await FirebaseFirestore.instance.collection("users").doc(userid).get();
  var name = coll2.data()!['name'];
  var regnumber = coll2.data()!['pnumber'];

  var coll1 =
      await FirebaseFirestore.instance.collection("bookings").doc(userid).get();
}

// Functions to get the appointments
List<Appointment> getAppointments(List<DateTime> dateTime) {
  List<Appointment> meetings = <Appointment>[];
  final date = dateTime;
  meetings = [];
  for (int i = 0; i < date.length; i++) {
    final DateTime startTime = DateTime(date[i].year, date[i].month,
        date[i].day, date[i].hour, date[i].minute, date[i].second);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Counseling',
      color: Colors.deepPurple,
    ));
  }
  return meetings;
}

Future<List<DateTime>> getapprovedDocIDs() async {
  try {
    var result = await FirebaseFirestore.instance
        .collection('bookings')
        .where('approval', isEqualTo: 'Approved')
        .get();
    var datesfound = result.docs;
    
      datescalendar = [];

    for (var date in datesfound) {
      DateTime dateBooked = date.data()['date_time_booked'].toDate();
      datescalendar.add(dateBooked);
    }
    return datescalendar;
  } on FirebaseException catch (e) {
    (e.message).toString();
    return datescalendar;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
