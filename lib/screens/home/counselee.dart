// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CounseleePage extends StatefulWidget {
  const CounseleePage({Key? key}) : super(key: key);

  @override
  State<CounseleePage> createState() => _CounseleePageState();
}

class _CounseleePageState extends State<CounseleePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [

                      // Name of the user
                      Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0), 
                      Text(
                        'Tildai',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // profile picture of the user
                  Icon(
                    Icons.person,
                  ),
                ],
              ),
            )
      
            // Card asking the counselee how they feel
      
            //  Search bar
      
            // Horizontal list view for categories
      
            // Counselors list
      
          ],
        ),
      ),

    );
  }
}