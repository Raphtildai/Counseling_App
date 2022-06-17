// ignore_for_file: prefer_const_constructors
import 'package:careapp/screens/authenticate/authentication.dart';
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
    home: BottomBarNav(),
    theme: ThemeData(primarySwatch: Colors.deepPurple),
  ));
}

