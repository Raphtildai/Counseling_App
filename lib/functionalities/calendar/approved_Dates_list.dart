// import 'package:careapp/functionalities/calendar/calendar_page.dart';
import 'package:careapp/functionalities/calendar/calendar_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ApprovedDatesList extends StatefulWidget {
  List<DateTime> datescalendar =[];
ApprovedDatesList({ Key? key, required this.datescalendar}) : super(key: key);

  @override
  State<ApprovedDatesList> createState() => _ApprovedDatesListState();
}

class _ApprovedDatesListState extends State<ApprovedDatesList> {
  // @override
  // void initState() {
  //   getapprovedDocIDs();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counselor\'s Schedule'),
        centerTitle: true,
      ),
      body: SfCalendar(
        minDate: DateTime.now(),
        maxDate: DateTime(2023),
        view: CalendarView.week,
        dataSource: MeetingDataSource(getAppointments(datescalendar)),
      ),
    );
  }
  @override
  void setState(VoidCallback fn) {
    datescalendar = [];
    super.setState(fn);
  }
}

// Functions to get the appointments
List<Appointment> getAppointments(List<DateTime> dateTime){
  List<Appointment> meetings = <Appointment>[];
  final date = dateTime;
  for(int i=0;i<date.length;i++){
    final DateTime startTime = DateTime(date[i].year, date[i].month, date[i].day, date[i].hour, date[i].minute, date[i].second);
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

class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Appointment> source){
    appointments = source;
  }
}