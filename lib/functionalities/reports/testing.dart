import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  final String docID;
  const Testing({ Key? key, required this.docID }) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
String name = '';
String regNumber = '';
getUserData() async {
  // var userid = doc;

  var coll2 = await FirebaseFirestore.instance.collection('users').doc(widget.docID).get();
  setState(() {
    name = coll2.data()!['firstname'];
    regNumber = coll2.data()!['regnumber'];
    var aboutCounselee = coll2.data()!['about'];
    var school = coll2.data()!['school'];
    var course = coll2.data()!['Course'];
  });
    
  

  // var coll1=await FirebaseFirestore.instance.collection("bookings").doc(userid).get();
}
@override
  void initState() {
    getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // getUserData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing'),
      ),
      body: Text('Name is $name'),
    );
  }
}