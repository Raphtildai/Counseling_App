// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_function_literals_in_foreach_calls

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
                            GetCounselorData(documentIds: docIDs[index])
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