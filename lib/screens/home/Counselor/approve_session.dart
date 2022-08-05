// import 'dart:js';

import 'package:careapp/services/get_counselee_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApproveSession extends StatefulWidget {
  const ApproveSession({ Key? key }) : super(key: key);

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
      body: FutureBuilder(
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
                    return const Center(child: Text('Something went Wrong'));
                  }
                  if(snapshot.hasData && !snapshot.data!.exists){
                    return const Center(child: Text('Sorry this request does not exist'),);
                  }

                  // Outputting the data to the user
                  if(snapshot.connectionState == ConnectionState.done){
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    // Sending email to the counselee informing them on their approval status
                    //Encoding email
                    String? encodeQueryParameters(Map<String, String>params){
                      return params.entries
                      .map((MapEntry<String, String>e) =>
                      '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeComponent(e.value)}'
                      ).join('&');
                    }
                    final email = Uri(
                      scheme: 'mailto',
                      path: '${data['email']}',
                      query: encodeQueryParameters(<String, String>{
                        'subject': 'Your Counseling Session was Approved',
                        'body': 'Hello,\n Your Counseling Session which you booked on ${data['created_at']}, for date: ${data['date_booked']} time: ${data['time_booked']}, has been approved.\n You\'ll be contacted by one of our counselors soon.\n\n Kind regards',
                      }),
                    );
                    Future<void>_sendEmail() async{
                      try{
                        if(await canLaunchUrl(email)){
                          await launchUrl(email);
                        }
                      }catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: const Text('Error while launching email sender app')),
                        );
                      }
                    }
                    // Function to approve session
                    Future approveSession(String docID) async {
                      try{
                        final approval = await FirebaseFirestore.instance.collection('bookings')
                        .doc('$docID').update({
                          'approval': "Approved",
                          'counseleeID' : FirebaseAuth.instance.currentUser!.uid,
                          'time_approved': DateTime.now(),
                        });
                        ApproveSession();
                        _sendEmail();
                      }
                      catch(e){
                        print(e);
                      }
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color:Colors.deepPurple[200], 
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    // Counselee's Reg number
                                    const Divider(
                                      // height: 10,
                                      thickness: 1.0,
                                      color: Colors.white,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Reg number:', style: titleStyle,),
                                        const SizedBox(width: 10,),
                                        Text('${data['regnumber']}'),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),

                                    // Date booked
                                    
                                    const Divider(
                                      // height: 10,
                                      thickness: 1.0,
                                      color: Colors.white,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Date Booked:', style: titleStyle,),
                                        const SizedBox(width: 10,),
                                        Text('${data['date_booked']}'),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),

                                    // Time booked
                                    const Divider(
                                      // height: 10,
                                      thickness: 1.0,
                                      color: Colors.white,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Time Booked:', style: titleStyle,),
                                        const SizedBox(width: 10,),
                                        Text('${data['time_booked']}'),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),

                                    // Reading more about the counselee
                                    const Divider(
                                      // height: 10,
                                      thickness: 1.0,
                                      color: Colors.white,
                                    ),
                                    MaterialButton(
                                      color: Colors.deepPurple,
                                      textColor: Colors.white,
                                      onPressed: (){
                                        // getCounseleeID('${data['regnumber']}');
                                        // print(counseleeID);
                                      },
                                      child: const Text('Counselee Profile'),
                                    ),
                                    
                                    const SizedBox(height: 10,),

                                    // Approval Buttons
                                    const Divider(
                                      // height: 10,
                                      thickness: 1.0,
                                      color: Colors.white,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          color: Colors.deepPurple,
                                          textColor: Colors.white,
                                          onPressed: (){
                                            print(docIDs[index]);
                                            approveSession(docIDs[index]);
                                          },
                                          child: const Text('Approve'),
                                        ),
                                        const SizedBox(width: 20,),
                                        MaterialButton(
                                          color: Colors.deepPurple[300],
                                          textColor: Colors.white,
                                          onPressed: (){},
                                          child: const Text('Reschedule'),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      // height: 10,
                                      thickness: 1.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Center(child: const CircularProgressIndicator());
                }
              );
            },
          );
        }),
      ),
    );
  }
}