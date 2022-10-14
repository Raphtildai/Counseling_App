// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace

import 'package:careapp/functionalities/session_booking.dart';
import 'package:careapp/screens/home/Counselee/counselee_list.dart';
import 'package:careapp/screens/home/Counselor/approve_session.dart';
import 'package:careapp/screens/home/message.dart';
import 'package:careapp/utilities/category_card.dart';
import 'package:careapp/utilities/counselee_card.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:careapp/utilities/neumorphicbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:careapp/utilities/booking_card.dart';
import 'package:flutter/services.dart';

class Counselors_Page extends StatefulWidget {
  const Counselors_Page({Key? key}) : super(key: key);

  @override
  State<Counselors_Page> createState() => _Counselors_PageState();
}

// creating a list of document IDs
List<String> docIDs = [];

class _Counselors_PageState extends State<Counselors_Page> {
  // accessing the user details
  final user = FirebaseAuth.instance.currentUser!;

  // Creating function to retrieve the documents
  Future getdocIDs() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: "counselee")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              // adding the document to the list
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
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
                        child: Image.asset('assets/icons/communication.png'),
                      ),
                    ),

                    SizedBox(
                      width: 20,
                    ),

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
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            '"We cannot teach people anything; We can only help them discover it within themselves."',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ApproveSession();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'Approve Sessions',
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

            SizedBox(
              height: 10,
            ),

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

            SizedBox(
              height: 10.0,
            ),

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

            SizedBox(
              height: 10.0,
            ),

            // Counselee Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Counselee List',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CounseleeList()));
                    }),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 15.0,
            ),

            FutureBuilder(
              future: getdocIDs(),
              initialData: ErrorPage('Fetching list of counselee'),
              builder: ((context, snapshot) {
                // Counselee
                return Container(
                  height: 250,
                  child: Expanded(
                    child: ListView.builder(
                      primary: false,
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // Get collection of counselee records
                        CollectionReference counselee =
                            FirebaseFirestore.instance.collection('users');
                        return FutureBuilder<DocumentSnapshot>(
                          future: counselee.doc(docIDs[index]).get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                // getImage(docIDs[index]);
                                return CounseleeCard(
                                  counseleeImage: '',
                                  counseleeReg: '${data['regnumber']}',
                                  counseleeName: '${data['firstname']}',
                                  counseleeCourse: '${data['Course']}',
                                  counseleeEmail: '${data['email']}',
                                  counseleePhone: '${data['pnumber']}',
                                  counseleeID: docIDs[index],
                                );
                              }
                            } else if (!snapshot.hasData) {
                              return ErrorPage("No Counselee Record exists");
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
