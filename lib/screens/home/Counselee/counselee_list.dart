// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:careapp/screens/home/Counselee/counselee_profile.dart';
import 'package:careapp/screens/home/Counselee/counselee_register.dart';
import 'package:careapp/services/get_counselee_data.dart';
import 'package:careapp/utilities/neumorphicbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CounseleeList extends StatelessWidget {

// accessing the user details
  final user = FirebaseAuth.instance.currentUser!;

  // creating a list of document IDs
  List <String> docIDs = [];

  // Creating function to retrieve the documents
  Future getdocIDs() async {

    await FirebaseFirestore.instance.collection('users').where('role', isEqualTo: "counselee").get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        // adding the document to the list
        docIDs.add(document.reference.id);
      }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Counselee'),
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
                  hintText: 'Search Counselee',
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
                // // Adding new counselor
                // ElevatedButton(
                //   onPressed: (){
                //     Navigator.of(context).push(MaterialPageRoute(builder: (context){
                //       return const CounseleeRegister();

                //     }));
                //   },
                //    child: const Text('New Counselee'),
                // ),
                // Searching counselor
                ElevatedButton(
                  onPressed: (){
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    //   return ;

                    // }));
                  },
                   child: const Text('Search Counselee'),
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
                    child: GestureDetector(
                      child: NeuBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              GetCounseleeData(documentIds: docIDs[index]),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return CounseleeProfile(counseleeID: docIDs[index],);
                                  }));
                                }, 
                                child: const Text('Read More'),
                              ),
                            ],
                          ),
                        )
                      ),
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