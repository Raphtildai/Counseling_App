import 'package:careapp/functionalities/appointments/appointment_card.dart';
import 'package:careapp/functionalities/appointments/reschedule_card.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        title: const Text('Pending Appointment(s)'),
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
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
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
                   child: const Text('Search Pending Approval'),
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
                color: Colors.deepPurple[100],
                thickness: 2.0,
              ),
            ),
      
            FutureBuilder(
              future: getdocIDs(),
              initialData: ErrorPage('Fetching List of Pending appointments'),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return snapshot.hasData
                      ? ErrorPage('${snapshot.data}')
                      : const Center(child: AlertDialog(content: Center(child: CircularProgressIndicator(),)));
                  case ConnectionState.done:
                  default:
                  if(snapshot.hasError){
                    return ErrorPage('${snapshot.error}');
                  }else if(snapshot.hasData){
                    return SizedBox(
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
                                // if(snapshot.hasData){
                                //   if(snapshot.connectionState == ConnectionState.done){
                                    Map <String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
                                    DateTime date = data['date_time_booked'].toDate();
                                    var date_booked = DateFormat('dd/MM/yyyy').format(date);
                                    var time_booked = DateFormat('HH:mm').format(date);
                                    DateTime created_at =data['created_at'].toDate();
                                    var day_of_booking = DateFormat('dd/MM/yyyy, HH:mm').format(created_at);
                                    return AppointmentCard(
                                      regnumber: '${data['regnumber']}', 
                                      date_booked: date_booked, 
                                      time_booked: time_booked, 
                                      counselee_email: '${data['counselee_email']}',
                                      created_at: day_of_booking,
                                      counseleeID: '${data['counseleeID']}',
                                      docID: docIDs[index], 
                                    );
                                //   }
                                // }
                                // else if(!snapshot.hasData){
                                //   return ErrorPage( "No Data found");
                                // }
                                return const Center(child: AlertDialog(content: Center(child: CircularProgressIndicator(),)));
                              },
                            );
                            
                          }),
                        ),
                      ),
                    );
                  }else{
                    return ErrorPage('No Pending Sessions to be approved');
                  }
                }
              },
            ),

            const SizedBox(height: 10,),
      
            Text('Pending Approval for Rescheduled Sessions', style: style,),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Divider(
                height: 10,
                color: Colors.deepPurple[100],
                thickness: 2.0,
              ),
            ),
      
            // SizedBox(height: 10,),
      
            FutureBuilder(
              future: getrescheduleddocIDs(),
              initialData: ErrorPage('Fetching List of Rescheduled appointments'),
              builder: (context, snapshot) {
                // switch (snapshot.connectionState) {
                //   case ConnectionState.waiting:
                //     return snapshot.hasData
                //       ? ErrorPage('${snapshot.data}')
                //       : const Center(child: AlertDialog(content: Center(child: CircularProgressIndicator(),)));
                //   case ConnectionState.done:
                //   default:
                //   if(snapshot.hasError){
                //     return ErrorPage('${snapshot.error}');
                //   }else if(snapshot.hasData){
                    return SizedBox(
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
                              // if(snapshot.hasData)  {
                              //   if(snapshot.connectionState == ConnectionState.done){

                                Map <String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
                                  DateTime date_rescheduled = data['date_time_rescheduled'].toDate();
                                  var date_rescheduled_to = DateFormat('dd/MM/yyyy').format(date_rescheduled);
                                  var time_rescheduled_to = DateFormat('HH:mm').format(date_rescheduled);
                                  DateTime rescheduled_at = data['rescheduled_at'].toDate();
                                  var day_of_rescheduling = DateFormat('dd/MM/yyyy, HH:mm').format(rescheduled_at);
                                
                                  return RescheduleCard( 
                                    date_rescheduled: date_rescheduled_to, 
                                    time_rescheduled: time_rescheduled_to, 
                                    counselee_email: '${data['counselee_email']}',
                                    rescheduled_at: day_of_rescheduling,
                                    counseleeID: '${data['counseleeID']}',
                                    reason: '${data['reason_for_reschedule']}',
                                    docID: rescheduleddocIDs[index], 
                                  );
                              //   }
                              // }else{
                              //   return ErrorPage("No Data Exists");
                              // }
                              
                              return const Center(child: CircularProgressIndicator(),);
                            },
                          );
                          
                        }),
                      ),
                    );
                //   }else{
                //     return ErrorPage('No Pending Rescheduled Sessions to be approved');
                //   }
                // }
              },
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Divider(
                height: 10,
                color: Colors.deepPurple[100],
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