// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace

import 'package:careapp/utilities/neumorphicbox.dart';
import 'package:flutter/material.dart';

import '../../../utilities/booking_card.dart';

class Counselors_page extends StatelessWidget {
  const Counselors_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   title: const Text('Counselor\'s Page'),
        //   centerTitle: true,
        // ),
        body: SingleChildScrollView(
          child:Column(
    
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10,),
    
              // Pending booking approvals
              CounselingBooking(),
              const SizedBox(height: 10,),
    
              // Counselee list
    
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: NeuBox(
                  child: Column(
                    children: const [
                      Text('Hello there'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              CounselingBooking(),
              SizedBox(height: 10,),
    
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      // width: 150,
                      child: ListView(
                        
                        scrollDirection: Axis.horizontal,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          NeuBox(child: Icon(Icons.abc)),
                          SizedBox(width: 30,),
                          NeuBox(child: Icon(Icons.abc)),
                          SizedBox(width: 30,),
                          NeuBox(child: Icon(Icons.abc)),
                          SizedBox(width: 30,),
                          NeuBox(child: Icon(Icons.abc)),
                          SizedBox(width: 30,),
                          NeuBox(child: Icon(Icons.abc)),
                          SizedBox(width: 30,),
                          NeuBox(child: Icon(Icons.abc)),
                          SizedBox(width: 30,),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}