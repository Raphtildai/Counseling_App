// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class CounseleeProfile extends StatelessWidget {
  final String counseleeID;
  CounseleeProfile({Key? key, required this.counseleeID}) : super(key: key);

  // Subtitle text style
  // ignore: prefer_const_constructors
  final subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  // paragraph text style
  final paragraph = const TextStyle(
    fontSize: 14,
    letterSpacing: 1,
  );



  @override
  Widget build(BuildContext context) {
    // Retrieving and Accessing Counselee details
    CollectionReference counselee = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: counselee.doc(counseleeID).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        // Error handling conditions
        if(snapshot.hasError){
          return Center(child: Text('Something went Wrong'));
        }
        if(snapshot.hasData && !snapshot.data!.exists){
          return Center(child: Text('The counselee Record does not exist'),);
        }

        // Outputting the data to the user
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
          appBar: AppBar(
            title: const Text('Counselee\'s Profile'),
          ),
          body: ListView(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 5,),
                    // Counselee's profile picture and basic details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurple[100],
              
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset('assets/counselor2.png')
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                    
                                // Name and other basic information
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Basic Details', style: subtitle,),
                                      Text('Name: ${data['firstname'] + ' ' + data['lastname']}',style: paragraph,),
                                      // Text('email: ${data['email']}', style: paragraph,),
                                      Text('Reg No: ${data['regnumber']}',style: paragraph,),
                                      Text('Age: ${data['age']}', style: paragraph,),
                                      Text('Residence: ${data['residence']}', style: paragraph,),                            
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              
                    const SizedBox(height: 10,),
              
                    // About the student
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurple[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('About the Counselee', style: subtitle,),
                                // Brief Description about the student
                                Text(
                                  '${data['about']}',
                                  style: paragraph,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              
                    const SizedBox(height: 10,),
              
                    // Counselee Education details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurple[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Education Details', style: subtitle,),
                                // School Enrolled
                                Text('School: ${data['school']}', style: paragraph,),
                                            
                                // Course Pursuing
                                Text('Course: ${data['Course']}', style: paragraph,),
                                            
                                // Year of Study
                                Text('Year of Study: ${data['year_of_study']}', style: paragraph,),
                                            
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10,),

                    // Counseling Sessions attended before
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurple[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Counseling Sessions History', style: subtitle,),
                                const SizedBox(height: 10,),
                                Image.asset('assets/graph.png'),                                        
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10,),
                    
                    // Contact information
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurple[100],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Contact details
                              Text('Contact Me', style: subtitle,),

                              const SizedBox(height: 10,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Message Me
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      // ignore: prefer_const_constructors
                                      Icon(
                                        Icons.message,
                                      ),
                                      Text('Message', style: paragraph,),
                                    ],
                                  ),

                                  // Call Me
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      // ignore: prefer_const_constructors
                                      Icon(
                                        Icons.phone
                                      ),
                                      Text('Call', style: paragraph,),
                                    ],
                                  ),

                                  // WhatsApp Me
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      // ignore: prefer_const_constructors
                                      Icon(
                                        Icons.whatsapp,
                                      ),
                                      Text('WhatsApp', style: paragraph,),
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        );  
      }
      return Center(child: CircularProgressIndicator(),);
      }
    );
  }
}