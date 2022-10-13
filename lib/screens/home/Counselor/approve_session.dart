// import 'dart:js';

import 'package:careapp/services/get_counselee_data.dart';
import 'package:careapp/utilities/booked_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ApproveSession extends StatefulWidget {
  const ApproveSession({ Key? key, }) : super(key: key);

  @override
  _ApproveSessionState createState() => _ApproveSessionState();
}

const titleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
const textStyle = TextStyle(
  fontSize: 14,
);
  // creating a list of document IDs
  List <String> docIDs = [];
  
  List<String> counseleeID = [];

  // Creating function to retrieve the documents
  Future getdocIDs() async {
    await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: "Pending").get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        // adding the document to the list
        docIDs.add(document.reference.id);
    }));
  }

class _ApproveSessionState extends State<ApproveSession> {
  @override
  Widget build(BuildContext context) {
    // Get counselee document ID
    Future getCounseleeID(regnumber) async {
      await FirebaseFirestore.instance.collection('users').where('regnumber', isEqualTo: regnumber).get().then(
        (snapshot) => snapshot.docs.forEach((document) {
          // Adding that document to the list     
          
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          counseleeID.add(document.reference.id); 
          return GetCounseleeData(documentIds: document.reference.id);
        }));  
        })
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approve Session'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getdocIDs(),
              builder: ((context, snapshot){
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    // Retrieving the approval requests
                    CollectionReference counselee = FirebaseFirestore.instance.collection('bookings');
                    CollectionReference counseleeId = FirebaseFirestore.instance.collection('users');
                    return FutureBuilder<DocumentSnapshot>(
                    future: counselee.doc(docIDs[index]).get(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          
                        // Error handling conditions
                        if(snapshot.hasError){
                          showDialog(context: context, builder: (context){
                            return const AlertDialog(
                              content: Text('Something went Wrong'),
                            );
                          }); 
                        }
                        if(snapshot.hasData && !snapshot.data!.exists){
                          showDialog(context: context, builder: (context){
                            return const AlertDialog(
                              content: Text('Sorry this request does not exist'),
                            );
                          }); 
                        }
          
                        // Outputting the data to the user
                        if(snapshot.connectionState == ConnectionState.done){
                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                           return Column(
                             children: [
                               BookedSession(
                                regnumber: '${data['regnumber']}', 
                                date_booked: '${data['date_booked']}', 
                                time_booked: '${data['time_booked']}', 
                                counseleeID: '${data['counseleeID']}',
                                counselee_email: '${data['counselee_email']}',
                                created_at: '${data['created_at']}',
                                docID: docIDs[index],
                              ),
                             ],
                           );
                        }
                        return const Center(child: CircularProgressIndicator());
                      }
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}