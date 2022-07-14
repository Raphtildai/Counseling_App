import 'package:careapp/utilities/neumorphicbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Account_page extends StatefulWidget {
  const Account_page({Key? key}) : super(key: key);

  @override
  State<Account_page> createState() => _Account_pageState();
}


@override
class _Account_pageState extends State<Account_page> {

CollectionReference _collectionReference = FirebaseFirestore.instance.collection('users');
late Stream<QuerySnapshot> _streamAdmins;

void initState() {
  super.initState();
  _streamAdmins = _collectionReference.snapshots();
}

  @override
  Widget build(BuildContext context) {
    
    // _collectionReference.snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _streamAdmins,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          if(snapshot.connectionState == ConnectionState.done){
            QuerySnapshot querySnapshot = snapshot.data;
            print(querySnapshot);
          }
          return Center(child: CircularProgressIndicator());
            // return Container(child: Center(child: Text('Nothing to show')),);
          },
        ),
      );
  }
}