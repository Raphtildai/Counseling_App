// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../../utilities/booking_card.dart';

class Counselors_page extends StatelessWidget {
  const Counselors_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Counselor\'s Page'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.deepPurple[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            Text(
                              'Hello There',
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(height: 5,),
                            const Text(
                            'Dr. Angela',
                            // ignore: unnecessary_const
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(width: 10,),

                        const Icon(
                          Icons.person,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              // Pending booking approvals

              const Text(
                'Pending Counseling Sessions Approvals',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10,),
              
              
              CounselingBooking(),
              const SizedBox(height: 10,),

              // Counselees list
            ],
          ),
        ],
      ),
    );
  }
}