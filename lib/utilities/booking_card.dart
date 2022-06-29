import 'package:flutter/material.dart';

class CounselingBooking extends StatelessWidget {
 CounselingBooking({Key? key}) : super(key: key);

  final myStyle = TextStyle(
    fontSize: 15,
    fontFamily: 'Sans-serif',
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.deepPurple[100],
          ),
          padding: EdgeInsets.symmetric(horizontal: 25),
          // height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          SizedBox(height: 5,),
                          // Course
                          Text('Course: BSc. Computer Science', style: myStyle,),
                          SizedBox(height: 5,),
                          // Date booked Session
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.deepPurple[200],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                          SizedBox(height: 10,),
                          // Phone Number
                          Text('+254725341547', style: myStyle,),
                          SizedBox(height: 5,),
                          // Approval button and Rescheduling Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Approval Button
                              MaterialButton(
                                color: Colors.deepPurple,
                                textColor: Colors.white,
                                hoverColor: Colors.green,
                                onPressed: (){
    
                                },
                                child: Text(
                                  'Approve',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Rescheduling button
                              MaterialButton(
                                color: Colors.red,
                                textColor: Colors.white,
                                hoverColor: Colors.red[900],
                                onPressed: (){
    
                                },
                                child: Text(
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}