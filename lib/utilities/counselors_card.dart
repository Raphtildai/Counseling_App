import 'dart:ui';

import 'package:careapp/screens/home/counselor_profile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CounselorCard extends StatelessWidget {


  // parameters to be passed to the Counselor's card
  final String counselorImage;
  final String counselorRating;
  final String counselorName;
  final String counselorProfession;
  final String counselorPhone;
  final String counselorEmail;

  // constructor

  CounselorCard({
    required this.counselorImage,
    required this.counselorRating,
    required this.counselorName,
    required this.counselorProfession,
    required this.counselorPhone,
    required this.counselorEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,0,0,0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: [
            //Picture of the Counselor 
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                counselorImage,
                height: 50,
              ),
            ),
            SizedBox(height: 5,),
      
            // Counselor's Rating
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow,),
                Text(counselorRating),
              ],
            ),
            SizedBox(height: 5,),
      
            // Counselors Name
            Text(
              counselorName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
      
            SizedBox(height: 5,),
      
            Text(counselorProfession),
      
            SizedBox(height: 5,),
      
            //Read more button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CounselorProfile();
                  
                },));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.deepPurple,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Read More', style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}