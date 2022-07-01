// ignore_for_file: prefer_const_constructors
import 'package:careapp/functionalities/booking.dart';
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/screens/home/counselor_profile.dart';
import 'package:careapp/screens/home/counselors_page.dart';
import 'package:careapp/screens/home/forgot_psw_page.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:careapp/screens/home/login.dart';
import 'package:careapp/screens/home/signup.dart';
import 'package:careapp/screens/home/user_page.dart';
import 'package:careapp/services/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:careapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:careapp/screens/home/counselee.dart';

void main()  {
  // WidgetsFlutterBinding.ensureInitialized;
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(primarySwatch: Colors.deepPurple),
  ));
}

