// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'package:careapp/screens/home/message.dart';
import 'package:careapp/screens/home/settings_page.dart';
import 'package:careapp/screens/home/user_account.dart';
import 'package:careapp/screens/home/user_page.dart';
import 'package:careapp/services/get_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/bottom_nav_bar.dart';

class Home extends StatefulWidget {

  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Default tab page
  int _selectedIndex = 0;

  void _navigateButtonBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  // Creating a list of pages

  final List <Widget> _pages = [
    User_page(),
    Message(),
    Settings_Page(),
    Account_page(),
    // search_page();
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
       
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _navigateButtonBar,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
    
  }
}