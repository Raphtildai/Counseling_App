import 'package:careapp/screens/home/Counselee/counselee_profile.dart';
import 'package:careapp/services/get_pending_session_approval_data.dart';
import 'package:careapp/utilities/neumorphicbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Approve extends StatelessWidget {

// accessing the user details
  final user = FirebaseAuth.instance.currentUser!;

  // creating a list of document IDs
  List <String> docIDs = [];

  // Creating function to retrieve the documents
  Future getdocIDs() async {

    await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: "Pending").get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        // adding the document to the list
        docIDs.add(document.reference.id);
      }));
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Approvals'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
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
                  hintText: 'Search approval requests',
                ),
              ),
            ),
          ),
    
          const SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // // Adding new counselor
                // ElevatedButton(
                //   onPressed: (){
                //     Navigator.of(context).push(MaterialPageRoute(builder: (context){
                //       return Register();

                //     }));
                //   },
                //    child: Text('New Counselor'),
                // ),
                // Searching counselor
                ElevatedButton(
                  onPressed: (){},
                   child: const Text('Search requests'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getdocIDs(),
              builder: ((context, snapshot) {
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: NeuBox(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const GetPendingSessionApprovalData(),
                              ElevatedButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return CounseleeProfile(counseleeID: docIDs[index],);
                                },));                                
                              }, 
                                child: const Text('Read More'),
                            ),
                          ],
                        ),
                      )
                    ),
                  );
                });
              }),
            )
          )
        ],
      ),
    );
  }
}