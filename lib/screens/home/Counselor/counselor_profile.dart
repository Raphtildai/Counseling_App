// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

class CounselorProfile extends StatelessWidget {
  final String counselorID;

  const CounselorProfile({super.key, required this.counselorID});

  @override
  Widget build(BuildContext context) {
    final String ID = counselorID; 
    // Retrieving the record of the specified counselor
    CollectionReference counselor = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: counselor.doc(counselorID).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        // Error handling conditions
        if(snapshot.hasError){
          return Center(child: Text('Something went Wrong'));
        }
        if(snapshot.hasData && !snapshot.data!.exists){
          return Center(child: Text('The counselor Record does not exist'),);
        }

        // Outputting the data to the user
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          // Encoding for SMS
          final Uri smsUri = Uri(
            scheme: 'sms',
            path: '${data['phonenumber']}',
          );
          
          Future<void> _message() async{
            try{
              if(await canLaunchUrl(smsUri)){
                await launchUrl(smsUri);
              }
            }catch (e){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Some error occurred'),
                ),
              );
            }
          }

          // Encoding phone calls
          final Uri callUri = Uri(
            scheme: 'tel',
            path: '${data['phonenumber']}'
          );
          Future<void> _call() async{
            try{
              if(await canLaunchUrl(callUri)){
                await launchUrl(callUri);
              }
            }catch (e){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Some error occurred'),
                ),
              );
            }
          }

          // Encoding Emails
          final mailUri = Uri(
            scheme: 'mailto',
            path: '${data['email']}',
          );
          Future<void> _email() async{
            try{
              if(await canLaunchUrl(mailUri)){
                await launchUrl(mailUri);
              }
            }catch (e){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Some error occurred'),
                ),
              );
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Counselor\'s Profile '),
            ),

            body: SafeArea(
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            // A picture at the left
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 200,
                                width: 150,
                                child: Image.asset('assets/bg.jpg'),
                              ),
                            ),

                            SizedBox(width: 20,),

                            // A message at the Right
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Name: ${data['firstname']} ' '${data['lastname']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 12.0,),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Specialization:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Text(
                                              '${data['profession']}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 12.0,),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
          
                      SizedBox(height: 10,),
          
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.deepPurple[100],
                          ),
                          // height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                                SizedBox(height: 10,),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('${data['about']}', style: TextStyle(
                                    fontSize: 14,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                          
                        ),
                      ),
          
                      SizedBox(height: 10,),    
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.deepPurple[100],
                          ),
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                    'Qualifications',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),

                                  SizedBox(height: 10,),

                                  Row(
                                    children: [
                                      Text(
                                        'License Number:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),

                                      SizedBox(width: 10,),

                                      Text(
                                        '${data['regnumber']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
          
                      SizedBox(height: 10,),
          
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.deepPurple[100],
                          ),
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  'Quotes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                                SizedBox(height: 10,),

                                Text(
                                  '"Emotional wellbeing is just as important to us as Breathing is!"',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(height: 10,),

                                Text(
                                  'BetterLYF',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],

                            ),
                          ),
                        ),
                      ),
          
                      SizedBox(height: 10,),
          
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.deepPurple[100],
                          ),
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    _message();
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.message,
                                      ),
                                      Text('Message Me'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    _call();
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.call,
                                      ),
                                      Text('Call Me'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () => _email(),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                      ),
                                      Text('Email Me'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          
                      SizedBox(height: 10,),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        // Return loading to the user
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}