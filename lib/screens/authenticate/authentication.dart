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
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Below checks any auth changes
      stream: FirebaseAuth.instance.authStateChanges(), 
      // Snapshot gives us information for the user
      builder: (context, snapshot){
        // String ID = userID;
        if(snapshot.hasData){
          CollectionReference user = FirebaseFirestore.instance.collection('users');
          return FutureBuilder<DocumentSnapshot>(
            future: user.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
              // Error handling conditions
              if(snapshot.hasError){
                return const AlertDialog(
                  content: Text('Something went Wrong.'),
                );
              }
              if(snapshot.hasData && !snapshot.data!.exists){
                showDialog(context: context, builder: (context){
                  return const AlertDialog(
                    content: Text('Sorry your account information cannot be found'),
                  );
                });
              }

              // Outputting the data to the user
              if(snapshot.connectionState == ConnectionState.done){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                if(data['role'] == 'admin'){
                  return const Home();
                }else if(data['role'] == 'counselor'){
                  return const CounselorHome();
                }else{
                  return const CounseleeHome();
                }
              }
              return const Center(child: CircularProgressIndicator());
            }
          );        
        }else{
          return const AuthPage();
        }
      }
    );
  }
}