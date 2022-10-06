import 'package:careapp/functionalities/calendar/approved_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
CalendarPage({ Key? key,}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

 
   List<DateTime> datescalendar =[];

class _CalendarPageState extends State<CalendarPage> {
    
  @override
  void initState() {
    // TODO: implement initState
      getapprovedDocIDs();
    super.initState();
   
 
  }
// List<String> approveddocIDs = [];
  @override
  Widget build(BuildContext context){
    //datescalendar=[];
  //  getapprovedDocIDs();
  setState(() {
    datescalendar =datescalendar;
  });
    
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
        dataSource: MeetingDataSource(getAppointments(datescalendar)),
      ),
    );
  }
}




Future Trysomething()async{
  var userid = FirebaseAuth.instance.currentUser!.uid;

  var coll2 =await FirebaseFirestore.instance.collection("users").doc(userid).get();
  var name=coll2.data()!['name'];
  var regnumber = coll2.data()!['pnumber'];
  

     var coll1=await FirebaseFirestore.instance.collection("bookings").doc(userid).get();


  


}
List<Appointment> getAppointments(List<DateTime> dateTime){

  ///var dateTime  = await getapprovedDocIDs();

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
  // return meetings;
  // return ApprovedList();
}

Future<List<DateTime>>getapprovedDocIDs() async{
//  datescalendar=[];

try {
  var result =  await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: 'Approved').get();
  var datesfound =  result.docs;

  for(var date in datesfound){
    //var stringdate = date.data()['date_time_booked'];
      DateTime rescheduled_at = date.data()['date_time_booked'].toDate();
      //var day_of_rescheduling = DateFormat('dd/MM/yyyy, HH:mm').format(rescheduled_at);
                            
    //var datefound =  rescheduled_at;//DateTime.fromMillisecondsSinceEpoch(stringdate*1000);
    datescalendar.add(rescheduled_at);
  }
  return datescalendar;
} catch (e) {
 return datescalendar;
  print(e);
}

 
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