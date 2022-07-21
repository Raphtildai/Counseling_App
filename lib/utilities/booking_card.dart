// ignore_for_file: sized_box_for_whitespace

import 'package:careapp/screens/home/Counselee/counselee_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CounselingBooking extends StatefulWidget {
 const CounselingBooking({Key? key,}) : super(key: key);

  @override
  State<CounselingBooking> createState() => _CounselingBookingState();
}

class _CounselingBookingState extends State<CounselingBooking> {
  final myStyle = const TextStyle(
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.deepPurple[100],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        // height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10,),
            // Title of the Card
            const Text(
              'Pending Counseling Sessions Approvals',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 150,
                      width: 100,
                      child: Image.asset('assets/counselor1.png'),
                    ),
                  ),
                ),
    
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Student Name
                        Text('Name: Raphael Tildai', style: myStyle,),
                        const SizedBox(height: 5,),
                        // Course
                        Text('Course: BSc. Computer Science', style: myStyle,),
                        const SizedBox(height: 5,),
                        // Date booked Session
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.deepPurple[200],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Date Booked',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '2022/07/23 6:30 PM',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        // Phone Number
                        Text('+254725341547', style: myStyle,),
                        const SizedBox(height: 5,),
                        // Approval button and Rescheduling Button
                        
                      ],
                      
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Approval Button
                MaterialButton(
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  hoverColor: Colors.green,
                  onPressed: (){

                  },
                  child: const Text(
                    'Approve',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                // Rescheduling button
                MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  hoverColor: Colors.red[900],
                  onPressed: (){

                  },
                  child: const Text(
                    'Reschedule',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
          
        ),
      ),
    );
  }
}