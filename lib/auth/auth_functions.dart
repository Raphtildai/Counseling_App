// ignore_for_file: prefer_const_constructors, unused_element, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class AuthFunctions extends StatelessWidget {
const AuthFunctions({ Key? key }) : super(key: key);



  @override
  Widget build(BuildContext context){
      // Logging in with email and password
  // Sign in function
  Future signIn() async{
    
      try{
        // Show circular loading while waiting for data
    showDialog(
      context: context, 
      builder: (context){
        // ignore: prefer_const_constructors
        return Center(child: CircularProgressIndicator());
      }
      );
        // This allows the user to login using email and password
        // await FirebaseAuth.instance.signInWithEmailAndPassword(
        //   email: _emailcontroller.text.trim(), 
        //   password: _passwordcontroller.text.trim(),  
        // );

        // Popping out the loading
          Navigator.of(context).pop();
          
        // Telling the user that sign in was successful
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text('Login success'),
            );
          }); 
        
      }on FirebaseAuthException catch(e){
        // print(e);
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        });
      }
  }
    return Container();
  }
}



  
  
  // Logging in with google
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signInGoogle() async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser == null){
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Storing those data into the firebase firestore
    await firestore.collection('users').doc(userCredential.user!.uid).set({
      'email':userCredential.user!.email,
      'name':userCredential.user!.displayName,
      'image':userCredential.user!.photoURL,
      'uid':userCredential.user!.uid,
      'date':DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now()),
    });
  }

