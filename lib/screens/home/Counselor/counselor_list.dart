// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_function_literals_in_foreach_calls
import 'package:careapp/screens/home/Counselor/counselor_profile.dart';
import 'package:careapp/screens/home/Counselor/register.dart';
import 'package:careapp/services/get_counselor_data.dart';
import 'package:careapp/utilities/neumorphicbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CounselorList extends StatelessWidget {
// accessing the user details
  final user = FirebaseAuth.instance.currentUser!;

  // creating a list of document IDs
  List <String> docIDs = [];

  // Creaing function to retrieve the documents
  Future getdocIDs() async {

    await FirebaseFirestore.instance.collection('users').where('role', isEqualTo: "counselor").get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        // adding the document to the list
        docIDs.add(document.reference.id);
      }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Counselors'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
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
                  hintText: 'Search Counselor',
                ),
              ),
            ),
          ),
    
          SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Adding new counselor
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return Register();

                    }));
                  },
                   child: Text('New Counselor'),
                ),
                // Searching counselor
                ElevatedButton(
                  onPressed: (){},
                   child: Text('Search Counselor'),
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
                            GetCounselorData(documentIds: docIDs[index]),
                              ElevatedButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return CounselorProfile(counselorID: docIDs[index],);
                                },));                                
                              }, 
                                child: Text('Read More'),
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