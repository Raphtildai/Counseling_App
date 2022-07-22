// ignore_for_file: prefer_const_constructors

import 'package:careapp/screens/home/home.dart';
import 'package:careapp/screens/home/message.dart';
import 'package:careapp/functionalities/settings_page.dart';
import 'package:careapp/screens/home/user_account.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  String title = 'Home';
  void titlepage(int index){
    setState(() {
      if(index == 0){
        title = 'Home';
      }
      else if(index == 1){
        title = 'Message';
      }else if(index == 2){
        title = 'Settings';
      }else{
        title = 'Account';
      }
    });
  }

  final myTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  // List of pages we want the Hidden Drawer to display
  List <ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      // Home Page
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: title,
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
          colorLineSelected: Colors.deepPurple,
        ), 
        Home(),
      ),

      // Message Page
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Chat',
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
          colorLineSelected: Colors.deepPurple,
        ), 
        Message(),
      ),
      // Settings Page
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Settings',
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
          colorLineSelected: Colors.deepPurple,
        ), 
        Settings_Page(),
      ),
      // Account Page
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Account',
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
          colorLineSelected: Colors.deepPurple,
        ), 
        UserAccount(),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages, 
      backgroundColorMenu: Colors.deepPurple.shade300,
      initPositionSelected: 0,
      slidePercent: 30,
      );
  }
}