// import 'package:careapp/hidden_drawer.dart';
import 'package:careapp/screens/authenticate/auth.dart';
import 'package:careapp/screens/home/Counselee/counselee_home.dart';
import 'package:careapp/screens/home/Counselee/counselee_list.dart';
import 'package:careapp/screens/home/Counselor/counselor_home.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {

  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      // Creating function to retrieve the documents
    Future getUserID() async {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: uid).get().then(
        (snapshot) => snapshot.docs.forEach((document) {
          if(ConnectionState == ConnectionState.done){
            setState(() {
              document.reference.id;
            });
          }else if(ConnectionState == ConnectionState.waiting){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text('Signing you in based on your user role'),
            );
          });
          }
        }));
    }
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Below checks any auth changes
      stream: FirebaseAuth.instance.authStateChanges(), //FirebaseAuth.instance.authStateChanges()
      // Snapshot gives us information for the user
      builder: (context, snapshot){
        // String ID = userID;
        if(snapshot.hasData){
          CollectionReference counselee = FirebaseFirestore.instance.collection('users');
          return FutureBuilder<DocumentSnapshot>(
            future: counselee.doc('JeyTqxAEqxMCSWH1LeuP').get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
              // Error handling conditions
              if(snapshot.hasError){
                // print(docid);
                // print(snapshot.error);
                return AlertDialog(
                  content: Text('Something went Wrong.'),
                );
              }
              if(snapshot.hasData && !snapshot.data!.exists){
                // print(FirebaseAuth.instance.currentUser?.email);
                // print(docid);
                showDialog(context: context, builder: (context){
                  return const AlertDialog(
                    content: Text('The User Record does not exist'),
                  );
                });
                // return const Center(child: Text('The User Record does not exist'),);
              }

              // Outputting the data to the user
              if(snapshot.connectionState == ConnectionState.done){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                if(data['role'] == 'admin'){
                  return Home();
                }else if(data['role'] == 'counselee'){
                  return const CounseleeHome();
                }else if(data['role'] == 'counselor'){
                  return const CounselorHome();
                }else{
                  return CounseleeList();
                }
              }
              return Center(child: CircularProgressIndicator());
            }
          );         
          
        }else{
          return const AuthPage();
        }
      }
      );
   }
}