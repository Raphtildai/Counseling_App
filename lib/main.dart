import 'dart:html';

import 'package:careapp/authentication.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:careapp/screens/login.dart';
import 'package:careapp/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:careapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: MainPage(),
  ));
  // runApp(MaterialApp(
  //   // Overwriting the initial route
  //   initialRoute: '/MainPage',
  //   // redirections
  //   routes: {
  //     '/MainPage':(context) => MainPage(),
  //     '/':(context) => SignUp(),
  //     '/home':(context) => Home(),
  //     '/login':(context) => LoginPage(),
  //   },
  // ));
}

