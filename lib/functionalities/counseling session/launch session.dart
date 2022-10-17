import 'package:careapp/functionalities/counseling%20session/counseling%20session%20card.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LaunchSession extends StatefulWidget {
  const LaunchSession({Key? key}) : super(key: key);

  @override
  State<LaunchSession> createState() => _LaunchSessionState();
}

List<String> approveddocIDs = [];

class _LaunchSessionState extends State<LaunchSession> {
  // Function to retrieve approved sessions
  Future getapproveddocIDs() async {
    await FirebaseFirestore.instance
        .collection('bookings')
        .where('approval', isEqualTo: 'Approved')
        .orderBy('date_booked')
        .get()
        .then((snapshot) {
      for (var document in snapshot.docs) {
        approveddocIDs.add(document.reference.id);
      }
    });
  }

  @override
  void initState() {
    approveddocIDs = [];
    super.initState();
  }

  var url = 'https://meet.google.com/?pli=1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launch Counseling Session'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getapproveddocIDs(),
              builder: (context, snapshot) {
                if (approveddocIDs.isEmpty) {
                  return ErrorPage('No Approved Sessions to Launch found');
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      primary: false,
                      itemCount: approveddocIDs.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: ((context, index) {
                        // We get the collection of the appointments
                        CollectionReference sessions =
                            FirebaseFirestore.instance.collection('bookings');
                        return FutureBuilder<DocumentSnapshot>(
                          future: sessions.doc(approveddocIDs[index]).get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data = snapshot.data!
                                  .data() as Map<String, dynamic>;

                              DateTime dateBooked =
                                  data['date_time_booked'].toDate();
                              var dateTimeBooked =
                                  DateFormat('dd/MM/yyyy').format(dateBooked);
                              var timeBooked =
                                  DateFormat('HH:mm').format(dateBooked);
                              return CounselingSessionCard(
                              date_booked: dateTimeBooked,
                              time_booked: timeBooked,
                              counselee_email: '${data['counselee_email']}',
                              counseleeID: approveddocIDs[index],
                              docID: approveddocIDs[index],
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      }),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
