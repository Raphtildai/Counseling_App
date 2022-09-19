import 'package:careapp/functionalities/counseling%20session/counseling%20session%20card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LaunchSession extends StatefulWidget {
LaunchSession({ Key? key }) : super(key: key);

  @override
  State<LaunchSession> createState() => _LaunchSessionState();
}
  List <String> approveddocIDs = [];

class _LaunchSessionState extends State<LaunchSession> {
  // Function to retrieve approved sessions
  Future getapproveddocIDs() async {
    await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: 'Approved').orderBy('date_booked').get().then((snapshot){
      snapshot.docs.forEach((document) { 
        approveddocIDs.add(document.reference.id);
      });
    });
  }
var url = 'https://meet.google.com/?pli=1';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Launch Counseling Session'),
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
                              return CounselingSessionCard(
                                regnumber: '${data['regnumber']}', 
                                date_booked: '${data['date_booked']}', 
                                time_booked: '${data['time_booked']}', 
                                counselee_email: '${data['counselee_email']}',
                                created_at: '${data['created_at']}',
                                counseleeID: '${data['counseleeID']}',
                                docID: approveddocIDs[index], 
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
          ],
        ),
      ),
    );
  }
}