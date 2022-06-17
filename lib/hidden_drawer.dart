import 'package:careapp/screens/home/home.dart';
import 'package:careapp/screens/home/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {

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
          name: 'Home Page',
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
          colorLineSelected: Colors.deepPurple,
        ), 
        Home(),
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