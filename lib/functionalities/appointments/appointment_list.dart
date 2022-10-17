// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

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
  List<String> docIDs = [];

  Future getdocIDs() async {
    await FirebaseFirestore.instance
        .collection('bookings')
        .where('approval', isEqualTo: 'Pending')
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        docIDs.add(doc.reference.id);
      }
    });
  }

  // For rescheduled appointments
  List<String> rescheduleddocIDs = [];
  Future getrescheduleddocIDs() async {
    await FirebaseFirestore.instance
        .collection('bookings')
        .where('approval', isEqualTo: 'Rescheduled')
        .get()
        .then((snapshot) {
      for (var document in snapshot.docs) {
        rescheduleddocIDs.add(document.reference.id);
      }
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
  Widget build(BuildContext context) {
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

            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Searching pending session
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Search Pending Approval'),
                  ),
                ],
              ),
            ),

            Text(
              'Pending Approval for first time booking',
              style: style,
            ),

            const SizedBox(
              height: 10,
            ),

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
                if (docIDs.isEmpty) {
                  return ErrorPage('No Pending Sessions to be approved');
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return snapshot.hasData
                          ? ErrorPage('${snapshot.data}')
                          : const Center(
                              child: AlertDialog(
                                  content: Center(
                              child: CircularProgressIndicator(),
                            )));
                    case ConnectionState.done:
                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                          primary: false,
                          itemCount: docIDs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            // We get the collection of the appointments
                            CollectionReference sessions = FirebaseFirestore
                                .instance
                                .collection('bookings');
                            return FutureBuilder<DocumentSnapshot>(
                              future: sessions.doc(docIDs[index]).get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    DateTime date =
                                        data['date_time_booked'].toDate();
                                    var dateBooked =
                                        DateFormat('dd/MM/yyyy').format(date);
                                    var timeBooked =
                                        DateFormat('HH:mm').format(date);
                                    DateTime createdAt =
                                        data['created_at'].toDate();
                                    var dayOfBooking =
                                        DateFormat('dd/MM/yyyy, HH:mm')
                                            .format(createdAt);
                                    return AppointmentCard(
                                      regnumber: '${data['regnumber']}',
                                      date_booked: dateBooked,
                                      time_booked: timeBooked,
                                      counselee_email:
                                          '${data['counselee_email']}',
                                      created_at: dayOfBooking,
                                      counseleeID: '${data['counseleeID']}',
                                      docID: docIDs[index],
                                    );
                                  }
                                }
                                return const Center(
                                    child: AlertDialog(
                                        content: Center(
                                  child: CircularProgressIndicator(),
                                )));
                              },
                            );
                          }),
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return ErrorPage('${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return ErrorPage('No data');
                      } else {
                        return ErrorPage('No Pending Sessions to be approved');
                      }
                  }
                }
              },
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              'Pending Approval for Rescheduled Sessions',
              style: style,
            ),

            const SizedBox(
              height: 10,
            ),

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
              initialData:
                  ErrorPage('Fetching List of Rescheduled appointments'),
              builder: (context, snapshot) {
                if (rescheduleddocIDs.isEmpty) {
                  return ErrorPage(
                      'No Pending Rescheduled Sessions to be approved');
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return snapshot.hasData
                          ? ErrorPage('${snapshot.data}')
                          : const Center(
                              child: AlertDialog(
                                  content: Center(
                              child: CircularProgressIndicator(),
                            )));
                    case ConnectionState.done:
                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                          primary: false,
                          itemCount: rescheduleddocIDs.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: ((context, index) {
                            // We get the collection of the appointments
                            CollectionReference rescheduledSessions =
                                FirebaseFirestore.instance
                                    .collection('bookings');
                            return FutureBuilder<DocumentSnapshot>(
                              future: rescheduledSessions
                                  .doc(rescheduleddocIDs[index])
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    DateTime dateRescheduled =
                                        data['date_time_rescheduled'].toDate();
                                    var dateRescheduledTo =
                                        DateFormat('dd/MM/yyyy')
                                            .format(dateRescheduled);
                                    var timeRescheduledTo =
                                        DateFormat('HH:mm')
                                            .format(dateRescheduled);
                                    DateTime rescheduledAt =
                                        data['rescheduled_at'].toDate();
                                    var dayOfRescheduling =
                                        DateFormat('dd/MM/yyyy, HH:mm')
                                            .format(rescheduledAt);

                                    return RescheduleCard(
                                      date_rescheduled: dateRescheduledTo,
                                      time_rescheduled: timeRescheduledTo,
                                      counselee_email:
                                          '${data['counselee_email']}',
                                      rescheduled_at: dayOfRescheduling,
                                      counseleeID: '${data['counseleeID']}',
                                      reason:
                                          '${data['reason_for_reschedule']}',
                                      docID: rescheduleddocIDs[index],
                                    );
                                  }
                                }

                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          }),
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return ErrorPage('${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return ErrorPage('No data found');
                      } else {
                        return ErrorPage('${snapshot.error}');
                      }
                  }
                }
              },
            ),

            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Divider(
                height: 10,
                color: Colors.deepPurple[100],
                thickness: 2.0,
              ),
            ),

            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
