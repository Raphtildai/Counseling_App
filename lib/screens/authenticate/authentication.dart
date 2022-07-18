// import 'package:careapp/hidden_drawer.dart';
import 'package:careapp/screens/authenticate/auth.dart';
import 'package:careapp/screens/home/Counselee/counselee_home.dart';
import 'package:careapp/screens/home/Counselor/counselor_home.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Future myrole() async{
  //   final role = await FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'admin');
  //   if(role == 'admin'){
      
  //   }else if(role == 'user'){
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
  //       return Home();
  //     }));
  //   }else{
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
  //       return Home();
  //     }));
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder<User?>(
      // Below checks any auth changes
      stream: FirebaseAuth.instance.authStateChanges(),
      // Snapshot gives us information for the user
      builder: (context, snapshot){
        if(snapshot.hasData){
          // Accessing counselee 
          CollectionReference counselor = FirebaseFirestore.instance.collection('users');
          return FutureBuilder<DocumentSnapshot>(
            future: counselor.doc('6WGtJKCXUXmTJNWu9Kb0').get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
              // Error handling conditions
              if(snapshot.hasError){
                return Center(child: Text('Something went Wrong'));
              }
              if(snapshot.hasData && !snapshot.data!.exists){
                return Center(child: Text('The counselor Record does not exist'),);
              }

              // Outputting the data to the user
              if(snapshot.connectionState == ConnectionState.done){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                if(data['role'] == 'admin'){
                  return Home();
                }else if(data['role'] == 'counselor'){
                  return CounselorHome();
                }else{
                  return CounseleeHome();
                }
              }
              return Center(child: CircularProgressIndicator(),);
            }
          );

          // Navigator.of(context).pushReplacementNamed('/home');
          // return Home();
          
        }else{
          return const AuthPage();
        }
      }
      );
  }
}