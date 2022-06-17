import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class BottomBarNav extends StatefulWidget {
  const BottomBarNav({Key? key}) : super(key: key);

  @override
  State<BottomBarNav> createState() => _BottomBarNavState();
}

class _BottomBarNavState extends State<BottomBarNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        backgroundColor: Colors.deepPurple,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.deepPurple.shade400,
        tabs: const [
          // Elements in the bottom navigation
          GButton(
            gap: 8,
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            gap: 8,
            icon: Icons.favorite_border,
            text: 'Favorite',
            ),
          GButton(
            gap: 8,
            icon: Icons.search,
            text: 'Search',
            ),
          GButton(
            gap: 8,
            icon: Icons.settings,
            text: 'Settings',
            ),
        ],  
      ),
    );
  }
}