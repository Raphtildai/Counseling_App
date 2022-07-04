// ignore_for_file: prefer_const_constructors

import 'package:careapp/functionalities/booking.dart';
import 'package:careapp/utilities/category_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utilities/counselors_card.dart';
import '../Counselor/counselor_profile.dart';

class CounseleePage extends StatefulWidget {
  
  @override
  State<CounseleePage> createState() => _CounseleePageState();
}

class _CounseleePageState extends State<CounseleePage> {
  final String email = 'raphaeltildai6@gmail.com';
  final String phone = '+254725341547';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         // ignore: prefer_const_literals_to_create_immutables
              //         children: [
        
              //           // Name of the user
              //           Text(
              //             'Hello',
              //             style: TextStyle(
              //               fontSize: 16.0,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           SizedBox(height: 8.0), 
              //           Text(
              //             'Tildai',
              //             style: TextStyle(
              //               fontSize: 20.0,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //       // profile picture of the user
              //       GestureDetector(

              //         onTap: (){
              //           try{
              //             // Loading
              //             showDialog(
              //               context: context, 
              //               builder: (context){
              //                 return Center(
              //                   child: CircularProgressIndicator(),
              //                 );
              //               }
              //               );
              //               // Pop out the loading widget
              //               Navigator.of(context).pop();
              //             FirebaseAuth.instance.signOut();
              //             showDialog(context: context, builder: (context){
              //               return AlertDialog(
              //                 content: Text('You have Logged Out'),
              //               );
              //             });
                          
              //           }on FirebaseAuthException catch(e){
              //             // Loading
              //             showDialog(
              //               context: context, 
              //               builder: (context){
              //                 return Center(
              //                   child: CircularProgressIndicator(),
              //                 );
              //               }
              //             );
              //             // Pop out the loading widget
              //             Navigator.of(context).pop();
              //             showDialog(context: context, builder: (context){
              //               return AlertDialog(
              //                 content: Text(e.message.toString()),
              //               );
              //             });
              //           };
              //         },


              //         child: Container(
              //           padding: EdgeInsets.all(12),
              //           decoration: BoxDecoration(
              //             color: Colors.deepPurple[50],
              //             borderRadius: BorderRadius.circular(15.0),
              //           ),
              //           child: Icon(
              //             Icons.person,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
        
              SizedBox(height: 10),
              
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
                          child: Image.asset('assets/icons/conversation.png'),
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
                                    'Book your Session',
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
        
              SizedBox(height: 10,),
              
              //  Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: 'How can we help you?',
                    ),
                  ),
                ),
              ),
        
              SizedBox(height: 10.0,),
            
              // Horizontal list view for categories -> What we offer
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                height: 80,
                // color: Colors.deepPurple[50],
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryCard(
                      iconImagePath: 'assets/icons/counsellor.png',
                      categoryName: 'Mindfulness Based Therapy',
                    ),
                    CategoryCard(
                      iconImagePath: 'assets/icons/conversation.png',
                      categoryName: 'Cognitive Based Therapy',
                    ),
                    CategoryCard(
                      iconImagePath: 'assets/icons/talking.png',
                      categoryName: 'Rational Emotive Therapy',
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: 10.0,),
            
              // Counselors list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Counselors List',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 15.0,),
        
              // Counselors
              Container(
                height: 200,
                child: Expanded(
                  child: ListView(
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    children: [
                      CounselorCard(
                        counselorImage: 'assets/bg.jpg',
                        counselorRating: '5.0',
                        counselorName: 'Dr. Angela',
                        counselorProfession: 'Student Counselor',
                        counselorEmail: email,
                        counselorPhone: phone,
                      ),
                      CounselorCard(
                        counselorImage: 'assets/counselor1.png',
                        counselorRating: '5.0',
                        counselorName: 'Dr. Angela',
                        counselorProfession: 'Student Counselor',
                        counselorEmail: email,
                        counselorPhone: phone,
                      ),
                      CounselorCard(
                        counselorImage: 'assets/counselor2.png',
                        counselorRating: '5.0',
                        counselorName: 'Dr. Angela',
                        counselorProfession: 'Student Counselor',
                        counselorEmail: email,
                        counselorPhone: phone,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}