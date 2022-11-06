// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:careapp/functionalities/calendar/approved_Dates_list.dart';
import 'package:careapp/functionalities/session_booking.dart';
import 'package:careapp/screens/home/Counselor/counselor_list.dart';
import 'package:careapp/utilities/category_card.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:careapp/utilities/session_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


class CounseleePage extends StatefulWidget {
const  CounseleePage({Key? key}) : super(key: key);
  
  @override
  State<CounseleePage> createState() => _CounseleePageState();
}

class _CounseleePageState extends State<CounseleePage> {

  // accessing the user details
  final user = FirebaseAuth.instance.currentUser!;
  
  //Function to launch more about counseling
  final Uri url = Uri.parse('https://www.counseling.org/aca-community/learn-about-counseling/what-is-counseling');


  Future<void> _launchUrl() async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  // creating a list of document IDs
  List <String> docIDs = [];
  // DateTime date = DateTime.now();

  // Creaing function to retrieve the documents
  Future getdocIDs() async {

    await FirebaseFirestore.instance.collection('bookings').where('counselee_email', isEqualTo: FirebaseAuth.instance.currentUser!.email).get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        // adding the document to the list
        docIDs.add(document.reference.id);
      }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                                    return SessionBooking();
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
                  children: const [
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

              // Booked counseling sessions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My bookings',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=> CounselorList()));
                    //   },
                    //   child: Text(
                    //     'See All',
                    //     style: TextStyle(
                    //       color: Colors.blue,
                    //       fontSize: 16.0,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              
              SizedBox(height: 15.0,),

              FutureBuilder(
                future: getdocIDs(),
                builder:((context, snapshot){
                  // List of counseling sessions booked
                  if(docIDs.isEmpty){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[200],
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('You haven\'t made any bookings yet'),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                child: const Text('Read about Counseling'),
                                onPressed: () {
                                  _launchUrl();
                                },
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  }else{
                  return Container(
                    height: 300,
                    child: ListView.builder(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        // Get collection
                        CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');
                        return FutureBuilder<DocumentSnapshot>(
                          future: bookings.doc(FirebaseAuth.instance.currentUser!.uid).get(),
                          builder: (context, snapshot){
                            if(snapshot.hasData == true){
                              if(snapshot.connectionState == ConnectionState.done){
                                Map <String, dynamic> data = 
                                snapshot.data!.data() as Map <String, dynamic>;
                                DateTime date = data['date_time_booked'].toDate();
                                var date_booked = DateFormat('dd/MM/yyyy').format(date);
                                var time_booked = DateFormat('HH:mm').format(date);
                                DateTime creatation_date = data['created_at'].toDate();
                                var created_at = DateFormat('dd/MM/yyyy, HH:mm').format(creatation_date);
                                
                                return SessionCard(
                                  date_booked: date_booked.toString(), //${data['final']}
                                  time_booked: time_booked.toString(),
                                  status: '${data['approval']}',
                                  // time_booked: data['time_booked'], 
                                  counselorID: '${data['counselorID']}', 
                                  counselor_email: '${data['counselor_email']}', 
                                  date_created: created_at,
                                );
                              }
                            }else{
                              return ErrorPage('No Bookings available');
                            }
                            return Center(child: const AlertDialog(content: Center(child: CircularProgressIndicator())));
                          },
                        );
                        
                      }),
                  );

                  }
                }),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}