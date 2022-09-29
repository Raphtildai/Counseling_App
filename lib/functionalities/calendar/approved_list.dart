import 'package:careapp/functionalities/calendar/calendar_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ApprovedList extends StatefulWidget {
  const ApprovedList({ Key? key }) : super(key: key);

  @override
  _ApprovedListState createState() => _ApprovedListState();
}

List<String> approveddocIDs = [];


class _ApprovedListState extends State<ApprovedList> {
  // Function to retrieve approved sessions
  Future getapproveddocIDs() async {
    await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: 'Approved').orderBy('date_booked').get().then((snapshot){
      snapshot.docs.forEach((document) { 
        approveddocIDs.add(document.reference.id);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approved Session'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getapproveddocIDs(),
              builder: (context, snapshot) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Expanded(
                    child: ListView.builder(
                      primary: false,
                      itemCount: approveddocIDs.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: ((context, index) {
                        // We get the collection of the appointments
                        CollectionReference sessions = FirebaseFirestore.instance.collection('bookings');
                        return FutureBuilder <DocumentSnapshot>(
                          future: sessions.doc(approveddocIDs[index]).get(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              Map <String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
                              // List<Appointment> meetings = <Appointment>[];
                              // final DateTime today = DateTime(data['time_booked']);
                              // final DateTime startTime = DateTime(today.year, today.month, today.day, today.hour, today.minute, today.second);
                              // final DateTime endTime = startTime.add(const Duration(hours: 2));

                              // meetings.add(Appointment(
                              //   startTime: startTime,
                              //   endTime: endTime,
                              //   subject: 'Counseling',
                              //   color: Colors.deepPurple,
                              // )); 
                              return CalendarPage();
                            }
                            return Center(child: CircularProgressIndicator(),);
                          },
                        );
                      }),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}