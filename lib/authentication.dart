import 'package:careapp/main.dart';
import 'package:careapp/screens/authenticate/auth.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          return AuthPage();
        }
      }
      );
  }
}