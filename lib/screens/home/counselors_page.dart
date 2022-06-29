import 'package:flutter/material.dart';

import '../../utilities/booking_card.dart';

class Counselors_page extends StatelessWidget {
  Counselors_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Counselor\'s Page'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.deepPurple[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              'Hello There',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(height: 5,),
                            Text(
                            'Dr. Angela',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(width: 10,),

                        Icon(
                          Icons.person,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              // Pending booking approvals

              Text(
                'Pending Counseling Sessions Approvals',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10,),
              
              
              CounselingBooking(),
              SizedBox(height: 10,),

              // Counselees list
            ],

            
          ),
          

        ],
      ),
    );
  }
}