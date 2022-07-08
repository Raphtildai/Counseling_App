// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings
import 'package:careapp/screens/home/Counselee/counselee.dart';
import 'package:careapp/screens/home/Counselor/counselors_page.dart';
import 'package:careapp/screens/home/message.dart';
import 'package:careapp/functionalities/settings_page.dart';
import 'package:careapp/utilities/navigation_drawer.dart';
import 'package:flutter/material.dart';

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
    CounseleePage(),
    Message(),
    Settings_Page(),
    Counselors_page(),
    // search_page();
  ];



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashbord'),
        centerTitle: true,
      ),
      drawer: NavigationDrawer(),
      // drawer: Drawer(
       
      // ),
      body: CounseleePage(),
      // _pages[_selectedIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _selectedIndex,
      //   onTap: _navigateButtonBar,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Counselor'),
      //   ],
      // ),
    );
    
  }
}