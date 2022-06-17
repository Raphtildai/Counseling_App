import 'package:careapp/screens/home/login.dart';
import 'package:careapp/screens/home/signup.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  // creating a bool value to initially show the login page
  bool showLoginPage = true;

  // function to toggle the screens
  void toggleScreen () {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    // checking to see if its showing the login page
    if(showLoginPage){
      return LoginPage(ShowRegisterPage: toggleScreen);
    }else{
      return SignUp(ShowLoginPage: toggleScreen);
    }
  }
}