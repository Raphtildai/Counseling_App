// ignore_for_file: prefer_const_constructors
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/screens/authenticate/user_roles.dart';
import 'package:careapp/screens/home/logout.dart';
import 'package:flutter/material.dart';
import 'package:careapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
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