import 'package:flutter/material.dart';

class CounselorProfile extends StatelessWidget {
  const CounselorProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          height: 250,
                          width: 250,
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
                              'Dr. Angela',
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
                                        'Specilization:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        'Student Counselor',
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
                    height: 200,
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

                          Text('It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. '),
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
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  'License Number:',
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                SizedBox(width: 10,),

                                Text(
                                  '08752FC',
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
                          child: Column(
                            children: [
                              Icon(
                                Icons.message,
                              ),
                              Text('Message Me'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.call,
                              ),
                              Text('Call Me'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.whatsapp,
                              ),
                              Text('Whatsapp Me'),
                            ],
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
}