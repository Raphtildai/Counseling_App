// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:careapp/functionalities/calendar/approved_Dates_list.dart';
import 'package:careapp/functionalities/calendar/calendar_page.dart';
import 'package:careapp/models/auth_service.dart';
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/screens/authenticate/user_roles.dart';
import 'package:careapp/screens/home/logout.dart';
import 'package:flutter/cupertino.dart';
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
  runApp(const Main(
    // debugShowCheckedModeBanner: false,
    // home: Main(),
    // theme: ThemeData(primarySwatch: Colors.deepPurple),
  ));
}

class Main extends StatelessWidget {
const Main({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainPage(),
    theme: ThemeData(primarySwatch: Colors.deepPurple),

    );
  }
}

class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Splash> {


  Future getPage() async {
    // Future.delayed(Duration.zero, () {
    //   Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => MainPage()),
    //     (route) => false);
    // });
    // Future.delayed(Duration(seconds: 5), (() {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainPage())));
    // }));
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainPage())));
  }

  @override
  void initState(){
    super.initState();
    getPage();
    // Future.delayed(const Duration(seconds: 5),(){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainPage())));
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Student Counseling App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/logo1.png', height: 150, width: 150),
              const SizedBox(height: 20),
              const CupertinoActivityIndicator(
                radius: 20,
                color: Colors.deepPurple,
              )
            ],
          ),
        ),
      ),
    );
  }
}