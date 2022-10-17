// ignore_for_file: sized_box_for_whitespace

import 'package:careapp/screens/home/Counselee/counselee_register.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CounseleeProfile extends StatefulWidget {
  final String counseleeID;
  String imageUrl = "";

  CounseleeProfile({
    Key? key,
    required this.counseleeID,
  }) : super(key: key);

  @override
  State<CounseleeProfile> createState() => _CounseleeProfileState();
}

class _CounseleeProfileState extends State<CounseleeProfile> {
  // Subtitle text style
  final subtitle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
  
  // Function to get the user image
  Future getImage(String userId) async {
    try {
      Reference ref = await FirebaseStorage.instance
          .ref()
          .child("${widget.counseleeID}.jpg");
      if (ref != null) {
        // Getting the image url
        ref.getDownloadURL().then((value) {
          setState(() {
            widget.imageUrl = value;
          });
        });
      } else {
        return widget.imageUrl = "";
      }
    } catch (e) {
      return ErrorPage('$e');
    }
  }

  // paragraph text style
  final paragraph = const TextStyle(
    fontSize: 14,
    letterSpacing: 1,
  );

  @override
  void initState() {
    getImage(widget.counseleeID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieving and Accessing Counselee details
    CollectionReference counselee =
        FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: counselee.doc(widget.counseleeID).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // Error handling conditions
          if (snapshot.hasError) {
            showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: Text('Something went Wrong'),
                  );
                });
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: Text('The counselee Record does not exist'),
                  );
                });
          }

          // Outputting the data to the user
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            // Encoding for SMS
            final Uri smsUri = Uri(
              scheme: 'sms',
              path: '+254${data['pnumber']}',
            );

            Future<void> _message() async {
              try {
                if (await canLaunchUrl(smsUri)) {
                  await launchUrl(smsUri);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Some error occurred'),
                  ),
                );
              }
            }

            // Encoding phone calls
            final Uri callUri =
                Uri(scheme: 'tel', path: '+254${data['pnumber']}');
            Future<void> _call() async {
              try {
                if (await canLaunchUrl(callUri)) {
                  await launchUrl(callUri);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Some error occurred'),
                  ),
                );
              }
            }

            // Encoding Emails
            final mailUri = Uri(
              scheme: 'mailto',
              path: '${data['email']}',
            );
            Future<void> _email() async {
              try {
                if (await canLaunchUrl(mailUri)) {
                  await launchUrl(mailUri);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Some error occurred'),
                  ),
                );
              }
            }

            return Scaffold(
              appBar: AppBar(
                title: Text(
                    '${data['firstname']} ' '${data['lastname']}\'s Profile '),
              ),
              body: ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      // Counselee's profile picture and basic details
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // A picture at the top
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        child: widget.imageUrl != ""
                                            ? Image.network(
                                                widget.imageUrl,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              )
                                            : const Icon(
                                                Icons.person,
                                                size: 100,
                                                color: Colors.black,
                                              ),
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      // Name and other basic information
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Basic Details',
                                            style: subtitle,
                                          ),
                                          Text(
                                            'Name: ${data['firstname'] + ' ' + data['lastname']}',
                                            style: paragraph,
                                          ),
                                          // Text('email: ${data['email']}', style: paragraph,),
                                          Text(
                                            'Reg No: ${data['regnumber']}',
                                            style: paragraph,
                                          ),
                                          Text(
                                            'Age: ${data['age']}',
                                            style: paragraph,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

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
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'About the Counselee',
                                  style: subtitle,
                                ),
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

                      const SizedBox(
                        height: 10,
                      ),

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
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Education Details',
                                  style: subtitle,
                                ),
                                // School Enrolled
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'School:',
                                      style: heading,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${data['school']}',
                                      style: paragraph,
                                    )),
                                  ],
                                ),

                                // Course Pursuing
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Course:',
                                      style: heading,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${data['Course']}',
                                      style: paragraph,
                                    )),
                                  ],
                                ),

                                // Year of Study
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Year of Study:',
                                      style: heading,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${data['year_of_study']}',
                                      style: paragraph,
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // const SizedBox(height: 10,),

                      // // Counseling Sessions attended before
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 25),
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(horizontal: 25),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(25),
                      //       color: Colors.deepPurple[100],
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(vertical: 10),
                      //       child: Expanded(
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text('Counseling Sessions History', style: subtitle,),
                      //             const SizedBox(height: 10,),
                      //             Image.asset('assets/graph.png'),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(
                        height: 10,
                      ),

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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                // Contact details
                                Text(
                                  'Contact Me',
                                  style: subtitle,
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Message Me
                                    GestureDetector(
                                      onTap: () {
                                        _message();
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          // ignore: prefer_const_constructors
                                          Icon(
                                            Icons.message,
                                          ),
                                          Text(
                                            'Send SMS',
                                            style: paragraph,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Call Me
                                    GestureDetector(
                                      onTap: () => _call(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          // ignore: prefer_const_constructors
                                          Icon(Icons.phone),
                                          Text(
                                            'Call',
                                            style: paragraph,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Email Me
                                    GestureDetector(
                                      onTap: () => _email(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          // ignore: prefer_const_constructors
                                          Icon(
                                            Icons.mail,
                                          ),
                                          Text(
                                            'Email',
                                            style: paragraph,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
