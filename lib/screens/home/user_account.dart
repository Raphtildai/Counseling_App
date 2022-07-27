// ignore_for_file: camel_case_types, prefer_final_fields, annotate_overrides, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
const UserAccount({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    const headingStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    const textStyle = TextStyle(
      fontSize: 14,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('Personal Information', style: headingStyle,),
                    const Text('This is what others will see on your Counseling profile.', style: textStyle,)
                  ],
                ),
              ),
              // Account profile picture
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  // height: MediaQuery.of(context).size.height - 200,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(height: 20,),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        child: Image.asset(
                          'assets/raph.PNG',
                          height: 100,
                          width: 400,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Icon(
                            Icons.edit,
                          ),
                          // const SizedBox(width: 10,),
                          const Text('Change Account Picture'),
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                  
                ),
              ),
              SizedBox(height: 10,),
        
              // Name and basic details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  // height: 200,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(height: 10,),
                      // Name
                      Text('Name: ', style: textStyle,),
                      const SizedBox(height: 10,),
                      // Email address
                      Text('Email: ', style: textStyle,),
                      const SizedBox(height: 10,),
                      // Phone number
                      Text('Phone Number: '),
                      const SizedBox(height: 10,),
                      // About
                      Text('About: '),
                      const SizedBox(height: 10,),
                    ],
                  ),
                  
                ),
              ),
              
            ],
          ),
        ),
      ),

    );
  }
}