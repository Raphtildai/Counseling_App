import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserData extends StatelessWidget {
  final String documentIds;

  GetUserData({required this.documentIds});

  @override
  Widget build(BuildContext context) {
    // Get collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentIds).get(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          Map <String, dynamic> data = 
          snapshot.data!.data() as Map <String, dynamic>;
          return Text(
            '${data['firstname']} ' + '${data['lastname']}, '
             + '${data['regnumber']}'
             );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}