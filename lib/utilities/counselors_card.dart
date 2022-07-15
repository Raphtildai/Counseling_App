// ignore_for_file: use_key_in_widget_constructors

import 'package:careapp/screens/home/Counselor/counselor_profile.dart';
import 'package:flutter/material.dart';

class CounselorCard extends StatelessWidget {


  // parameters to be passed to the Counselor's card
  final String counselorImage;
  final String counselorRating;
  final String counselorName;
  final String counselorProfession;
  final String counselorPhone;
  final String counselorEmail;
  final String counselorID;

  // constructor

  const CounselorCard({
    required this.counselorImage,
    required this.counselorRating,
    required this.counselorName,
    required this.counselorProfession,
    required this.counselorPhone,
    required this.counselorEmail,
    required this.counselorID,
  });

  @override
  Widget build(BuildContext context) {
    final String uid = counselorID;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,0,0,0),
      child: Container(
        padding: const EdgeInsets.all(10),
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
            const SizedBox(height: 5,),
      
            // Counselor's Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow,),
                Text(counselorRating),
              ],
            ),
            const SizedBox(height: 5,),
      
            // Counselors Name
            Text(
              counselorName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
      
            const SizedBox(height: 5,),
      
            Text(counselorProfession),
      
            const SizedBox(height: 5,),
      
            //Read more button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CounselorProfile(counselorID: this.counselorID,);
                  
                },));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.deepPurple,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
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