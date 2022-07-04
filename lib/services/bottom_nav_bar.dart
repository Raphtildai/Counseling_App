import 'package:careapp/functionalities/settings_page.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:careapp/functionalities/settings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class BottomBarNav extends StatefulWidget {
  const BottomBarNav({Key? key}) : super(key: key);

  @override
  State<BottomBarNav> createState() => _BottomBarNavState();
}

class _BottomBarNavState extends State<BottomBarNav> {

  // Default tab page
  int _selectedIndex = 0;

  void _navigateButtonBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  // Creating a list of pages

  final List <Widget> _pages = [
    Home(),
    Settings_Page(),
    // search_page();
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            backgroundColor: Colors.deepPurple,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.deepPurple.shade400,
            gap: 8,
            padding: EdgeInsets.all(16),
            onTabChange: (index){
              _navigateButtonBar(index);
            },
            tabs: const [
              // Elements in the bottom navigation
              GButton(
                gap: 8,
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Favorite',
                ),
              GButton(
                icon: Icons.search,
                text: 'Search',
                ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
                ),
            ],  
          ),
        ),
      ),
    );
  }
}