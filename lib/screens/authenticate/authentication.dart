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
 const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}
String userID = '';

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      // Creating function to retrieve the documents
    Future<void> getUserID() async {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: uid).get().then(
        (snapshot) => snapshot.docs.forEach((document) {
          if(ConnectionState == ConnectionState.done){
            String result = document.reference.id;
            setState(() {
              userID = result;
              print(userID);
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
                print(userID);
                print(snapshot.error);
                return const Center(child: Text('Something went Wrong'));
              }
              if(snapshot.hasData && !snapshot.data!.exists){
                print(FirebaseAuth.instance.currentUser?.email);
                print(userID);
                return const Center(child: Text('The User Record does not exist'),);
              }

              // Outputting the data to the user
              if(snapshot.connectionState == ConnectionState.done){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                if(data['role'] == 'admin'){
                  return Home();
                }else if(data['role'] == 'counselee'){
                  return CounseleeHome();
                }else if(data['role'] == 'counselor'){
                  return CounselorHome();
                }else{
                  return CounseleeList();
                }
              }
              return Scaffold(body: const Center(child: CircularProgressIndicator(),));
            }
          );         
          // if(User == admin){
          //   return Home();
          // }else if(User == counselee){
          //   return CounseleeHome();
          // }else if(User == counselor){
          //   return CounselorHome();
          // }else{
          //   return Booking();
          // }
        
          
          // Accessing counselee 
          // CollectionReference counselor = FirebaseFirestore.instance.collection('users');
          // return FutureBuilder<DocumentSnapshot>(
          //   future: counselor.doc(snapshot.data.toString()).get(),
          //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){        
          //     // Error handling conditions
          //     if(snapshot.hasError){
          //       return Scaffold(
          //         body: const Center(
          //           child: Text('Something went Wrong')
          //         )
          //       );
          //     }
          //     if(snapshot.hasData && !snapshot.data!.exists){
          //       // ignore: prefer_const_constructors
          //       return Scaffold(
          //         body: const Center(
          //           child: Text('The Record cannot be found'),
          //         )
          //       );
          //     }

          //     // Outputting the data to the user
          //     if(snapshot.connectionState == ConnectionState.done){
          //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          //       if(data['role'] == 'admin'){
          //         return Home();
          //       }else if(data['role'] == 'counselor'){
          //         return const CounselorHome();
          //       }else if(data['role'] == 'counselee'){
          //         return const CounseleeHome();
          //       }else{
          //         return User_page();
          //       }
          //     }
          //     return const Center(child: const CircularProgressIndicator(),);
          //   }
          // );
          // Navigator.of(context).pushReplacementNamed('/home');
          // return Home();
          
        }else{
          return const AuthPage();
        }
      }
      );
   }
}