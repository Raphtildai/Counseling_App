import 'package:careapp/functionalities/appointments/appointment_card.dart';
import 'package:careapp/functionalities/appointments/reschedule_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentList extends StatelessWidget {
  // Styles used in the app
  TextStyle style = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  // For !st time appointments
  List <String> docIDs = [];

  Future getdocIDs() async {
    var doc =await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: 'Pending').get().then((snapshot){
      snapshot.docs.forEach((doc) {
        docIDs.add(doc.reference.id);
      });
    });
  }
  // For rescheduled appointments
  List <String> rescheduleddocIDs = [];
  Future getrescheduleddocIDs() async {
    await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: 'Rescheduled').get().then((snapshot){
      snapshot.docs.forEach((document) { 
        rescheduleddocIDs.add(document.reference.id);
      });
    });
  }

  // // Search function
  // Future search() async {
  //   await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: 'Pending').get().then((snapshot){
  //     snapshot.docs.forEach((document) {
        
        
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Appointment(s)'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
          //  Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Search for pending sesion approval',
                ),
              ),
            ),
          ),
    
          const SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Searching pending session
                ElevatedButton(
                  onPressed: (){},
                   child: Text('Search Pending Approval'),
                ),
              ],
            ),
          ),

            Text('Pending Approval for first time booking', style: style,),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Divider(
                height: 10,
                color: Colors.deepPurple[200],
                thickness: 2.0,
              ),
            ),
      
            FutureBuilder(
              future: getdocIDs(),
              builder: (context, snapshot) {
                return Container(
                  height: 300,
                  child: Expanded(
                    child: ListView.builder(
                      primary: false,
                      itemCount: docIDs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        // We get the collection of the appointments
                        CollectionReference sessions = FirebaseFirestore.instance.collection('bookings');
                        return FutureBuilder <DocumentSnapshot>(
                          future: sessions.doc(docIDs[index]).get(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              Map <String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
                              return AppointmentCard(
                                regnumber: '${data['regnumber']}', 
                                date_booked: '${data['date_booked']}', 
                                time_booked: '${data['time_booked']}', 
                                counselee_email: '${data['counselee_email']}',
                                created_at: '${data['created_at']}',
                                counseleeID: '${data['counseleeID']}',
                                docID: docIDs[index], 
                              );
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

            const SizedBox(height: 10,),
      
            Text('Pending Approval for Rescheduled Sessions', style: style,),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Divider(
                height: 10,
                color: Colors.deepPurple[200],
                thickness: 2.0,
              ),
            ),
      
            // SizedBox(height: 10,),
      
            FutureBuilder(
              future: getrescheduleddocIDs(),
              builder: (context, snapshot) {
                return Container(
                  height: 350,
                  child: ListView.builder(
                    primary: false,
                    itemCount: rescheduleddocIDs.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) {
                      // We get the collection of the appointments
                      CollectionReference rescheduled_sessions = FirebaseFirestore.instance.collection('bookings');
                      return FutureBuilder <DocumentSnapshot>(
                        future: rescheduled_sessions.doc(rescheduleddocIDs[index]).get(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            Map <String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
                            return RescheduleCard(
                              regnumber: '${data['regnumber']}', 
                              date_rescheduled: '${data['date_rescheduled']}', 
                              time_rescheduled: '${data['time_rescheduled']}', 
                              counselee_email: '${data['counselee_email']}',
                              rescheduled_at: '${data['rescheduled_at']}',
                              counseleeID: '${data['counseleeID']}',
                              reason: '${data['reason_for_reschedule']}',
                              docID: rescheduleddocIDs[index],
                            );
                          }
                          return Center(child: CircularProgressIndicator(),);
                        },
                      );
                      
                    }),
                  ),
                );
              },
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Divider(
                height: 10,
                color: Colors.deepPurple[200],
                thickness: 2.0,
              ),
            ),

            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}