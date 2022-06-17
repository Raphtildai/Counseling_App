// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'package:careapp/services/get_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // accessing the user details
  final user = FirebaseAuth.instance.currentUser!;

  // creating a list of document IDs
  List <String> docIDs = [];

  // Creaing function to retrieve the documents
  Future getdocIDs() async {

    await FirebaseFirestore.instance.collection('users').orderBy('regnumber').get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        // adding the document to the list
        docIDs.add(document.reference.id);
      }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user.displayName}'),
        // centerTitle: true,
        backgroundColor: Colors.deepPurple.shade400,
        actions: [
          GestureDetector(
            onTap: (){
              try{
                // Loading
                showDialog(
                  context: context, 
                  builder: (context){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  );
                  // Pop out the loading widget
                  Navigator.of(context).pop();
                FirebaseAuth.instance.signOut();
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: Text('You have Logged Out'),
                  );
                });
                
              }on FirebaseAuthException catch(e){
                // Loading
                showDialog(
                  context: context, 
                  builder: (context){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                );
                // Pop out the loading widget
                Navigator.of(context).pop();
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: Text(e.message.toString()),
                  );
                });
              };
            },
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(Icons.logout),
                Text('Logout'),
              ],
            ),
            ),
        ],
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
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: GetUserData(documentIds: docIDs[index]),
                      tileColor: Colors.grey[300],
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