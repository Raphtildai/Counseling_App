import 'package:careapp/functionalities/calendar/approved_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
CalendarPage({ Key? key, }) : super(key: key);
// List<String> approveddocIDs = [];
  @override
  Widget build(BuildContext context){
  // final DateTime today = DateTime(date.year, date.month, date.day, date.hour, date.minute, date.second);
  // final DateTime startTime = DateTime(date.year, date.month, date.day, date.hour, date.minute, date.second);
  // final DateTime endTime = startTime.add(const Duration(hours: 2));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counselor\'s Calendar Schedule'),
        centerTitle: true,
      ),
      body: SfCalendar(
        view: CalendarView.week,
        // dataSource: ApprovedList(),
        dataSource: MeetingDataSource(getAppointments()),
      ),
    );
  }
}

List<Appointment> getAppointments(){
  // List<Appointment> meetings = <Appointment>[];
  // FutureBuilder(
  //   future: getapprovedDocIDs(),
  //   builder: (context, snapshot) {
  //     return Container(
  //       height: MediaQuery.of(context).size.height,
  //       child: Expanded(
  //         child: ListView.builder(
  //           primary: false,
  //           itemCount: approveddocIDs.length,
  //           scrollDirection: Axis.vertical,
  //           itemBuilder: ((context, index) {
  //             // We get the collection of the appointments
  //             CollectionReference sessions = FirebaseFirestore.instance.collection('bookings');
  //             return FutureBuilder <DocumentSnapshot>(
  //               future: sessions.doc(approveddocIDs[index]).get(),
  //               builder: (context, snapshot) {
  //                 if(snapshot.connectionState == ConnectionState.done){
  //                   Map <String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
  //                   List<Appointment> meetings = <Appointment>[];
  //                   final DateTime today = DateTime(data['time_booked']);
  //                   final DateTime startTime = DateTime(today.year, today.month, today.day, today.hour, today.minute, today.second);
  //                   final DateTime endTime = startTime.add(const Duration(hours: 2));
  //                 }
  //                 return Center(child: CircularProgressIndicator(),);
  //               },
  //             );
  //           }),
  //         ),
  //       ),
  //     );
  //   },
  // );
  
  List<Appointment> meetings = <Appointment>[];
  // final DateTime startTime = DateTime(date.year, date.month, date.day, date.hour, date.minute, date.second);
  // final DateTime endTime = startTime.add(const Duration(hours: 2));
  //   meetings.add(Appointment(
  //     startTime: startTime,
  //     endTime: endTime,
  //     subject: 'Counseling',
  //     color: Colors.deepPurple,
  //   )); 
    return meetings;
  // return meetings;
  // return ApprovedList();
}

getapprovedDocIDs() async{
  await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: 'Approved').orderBy('date_booked').get().then((snapshot){
    snapshot.docs.forEach((document) { 
      approveddocIDs.add(document.reference.id);
    });
  });
}

class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Appointment> source){
appointments = source;
  }
}


  // final DateTime today = DateTime.now();
  // final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
  // final DateTime endTime = startTime.add(const Duration(hours: 2));

  // meetings.add(Appointment(
  //   startTime: startTime,
  //   endTime: endTime,
  //   subject: 'Counseling',
  //   color: Colors.deepPurple,
  // )); 
// class MeetingdataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source){
//     appointments = source;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }

//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }

//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }

//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }
// }

// class Meeting {
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   bool isAllDay;
// }