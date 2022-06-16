import 'package:careapp/main.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:careapp/screens/login.dart';
import 'package:careapp/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Below checks any auth changes
      stream: FirebaseAuth.instance.authStateChanges(),
      // Snapshot gives us information for the user
      builder: (context, snapshot){
        if(snapshot.hasData){
          // Navigator.of(context).pushReplacementNamed('/home');

          return Home();
        }else{
          return LoginPage();
        }
      }
      );
  }
}