// ignore_for_file: prefer_const_constructors
import 'package:careapp/functionalities/booking.dart';
import 'package:careapp/screens/home/Counselor/register.dart';
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/screens/home/Counselor/counselor_profile.dart';
import 'package:careapp/screens/home/Counselor/counselors_page.dart';
import 'package:careapp/screens/home/forgot_psw_page.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:careapp/screens/home/login.dart';
import 'package:careapp/screens/home/signup.dart';
import 'package:careapp/screens/home/user_page.dart';
import 'package:careapp/services/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:careapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:careapp/screens/home/Counselee/counselee.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainPage(),
    theme: ThemeData(primarySwatch: Colors.deepPurple),
  ));
}

