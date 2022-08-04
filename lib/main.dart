// ignore_for_file: prefer_const_constructors
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:flutter/material.dart';
import 'package:careapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';

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
    home: SplashScreen(
      seconds: 14,
      navigateAfterSeconds: MainPage(),
      title: Text(
        'Welcome In SplashScreen',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.network(
          'https://flutter.io/images/catalog-widget-placeholder.png'),
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
    ),
    theme: ThemeData(primarySwatch: Colors.deepPurple),
  ));
}

