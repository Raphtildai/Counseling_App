// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace

import 'package:careapp/functionalities/booking.dart';
import 'package:careapp/utilities/neumorphicbox.dart';
import 'package:flutter/material.dart';

import '../../../utilities/booking_card.dart';

class Counselors_page extends StatelessWidget {
  const Counselors_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Counselor\'s Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            // Card asking the counselee how they feel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    // A picture at the left
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset('assets/icons/communication.png'),
                      ),
                    ),
      
                    SizedBox(width: 20,),
      
                    // A message at the Right
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Galileo once said:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 12.0,),
                          Text(
                            '"We cannot teach people anything; We can only help them discover it within themselves."',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return Booking();
                                },),);
                                },
                                child: Text(
                                  'Approve Sessions',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}