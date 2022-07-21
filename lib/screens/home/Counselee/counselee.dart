// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:careapp/functionalities/booking.dart';
import 'package:careapp/utilities/category_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utilities/counselors_card.dart';

class CounseleePage extends StatefulWidget {
  CounseleePage({Key? key}) : super(key: key);
  
  @override
  State<CounseleePage> createState() => _CounseleePageState();
}

class _CounseleePageState extends State<CounseleePage> {

  // accessing the user details
  final user = FirebaseAuth.instance.currentUser!;

  // creating a list of document IDs
  List <String> docIDs = [];

  // Creaing function to retrieve the documents
  Future getdocIDs() async {

    await FirebaseFirestore.instance.collection('users').where('role', isEqualTo: "counselor").get().then(
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
            
              // Counselors list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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

              FutureBuilder(
                future: getdocIDs(),
                builder:((context, snapshot){
                  // Counselors
                  return Container(
                    height: 200,
                    child: Expanded(
                      child: ListView.builder(
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          // Get collection
                          CollectionReference counselor = FirebaseFirestore.instance.collection('users');
                          return FutureBuilder<DocumentSnapshot>(
                            future: counselor.doc(docIDs[index]).get(),
                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.done){
                                Map <String, dynamic> data = 
                                snapshot.data!.data() as Map <String, dynamic>;
                                return CounselorCard(
                                  counselorImage: 'assets/bg.jpg',
                                  counselorRating: '${data['rating']}',
                                  counselorName: '${data['firstname']}',
                                  counselorProfession: '${data['profession']}',
                                  counselorEmail: '${data['email']}',
                                  counselorPhone: '${data['pnumber']}',
                                  counselorID: docIDs[index],
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                              
                            },
                          );
                          
                        }),
                      ),
                  );
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