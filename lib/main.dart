// ignore_for_file: prefer_const_constructors
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:careapp/services/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:careapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:careapp/services/bottom_nav_bar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: MainPage(),
    theme: ThemeData(primarySwatch: Colors.deepPurple),
  ));
}

