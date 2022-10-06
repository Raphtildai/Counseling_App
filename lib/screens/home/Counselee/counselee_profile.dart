// ignore_for_file: sized_box_for_whitespace

import 'package:careapp/screens/home/Counselee/counselee_register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class CounseleeProfile extends StatelessWidget {
  final String counseleeID;
  CounseleeProfile({Key? key, required this.counseleeID,}) : super(key: key);

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
          showDialog(context: context, builder: (context){
            return const AlertDialog(
              content: Text('Something went Wrong'),
            );
          }); 
        }
        if(snapshot.hasData && !snapshot.data!.exists){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text('The counselee Record does not exist'),
            );
          });
        }

        // Outputting the data to the user
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          // Encoding for SMS
          final Uri smsUri = Uri(
            scheme: 'sms',
            path: '+254${data['pnumber']}',
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
            path: '+254${data['pnumber']}'
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
            title: Text('${data['firstname']} ' '${data['lastname']}\'s Profile '),
          ),
          body: ListView(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    // Counselee's profile picture and basic details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurple[100],
              
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    // A picture at the top
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                                      child: Image.asset(
                                        'assets/counselor2.png',
                                        // height: 100,
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                    ),

                                    const SizedBox(height: 20,),
                                  
                                    // Name and other basic information
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('Basic Details', style: subtitle,),
                                        Text('Name: ${data['firstname'] + ' ' + data['lastname']}',style: paragraph,),
                                        // Text('email: ${data['email']}', style: paragraph,),
                                        Text('Reg No: ${data['regnumber']}',style: paragraph,),
                                        Text('Age: ${data['age']}', style: paragraph,),
                                        Text('Residence: ${data['residence']}', style: paragraph,), 
                                        const SizedBox(height: 10,),                           
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('School:', style: heading,),
                                    const SizedBox(width: 5,),
                                    Expanded(child: Text('${data['school']}', style: paragraph,)),
                                  ],
                                ),
                                            
                                // Course Pursuing
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Course:', style: heading,),
                                    const SizedBox(width: 5,),
                                    Expanded(child: Text('${data['Course']}', style: paragraph,)),
                                  ],
                                ),
                                            
                                // Year of Study
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Year of Study:', style: heading,),
                                    const SizedBox(width: 5,),
                                    Expanded(child: Text('${data['year_of_study']}', style: paragraph,)),
                                  ],
                                ),
                                            
                              ],
                            ),
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
                                  GestureDetector(
                                    onTap: (){
                                      _message();
                                      
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        // ignore: prefer_const_constructors
                                        Icon(
                                          Icons.message,
                                        ),
                                        Text('Send SMS', style: paragraph,),
                                      ],
                                    ),
                                  ),

                                  // Call Me
                                  GestureDetector(
                                    onTap: () => _call(),
                                    child: Column(
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
                                  ),

                                  // Email Me
                                  GestureDetector(
                                    onTap: () => _email(),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        // ignore: prefer_const_constructors
                                        Icon(
                                          Icons.mail,
                                        ),
                                        Text('Email', style: paragraph,),
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
                ),
              )
            ],
          ),
        );  
      }
        return const Center(child: AlertDialog(content: Center(child: CircularProgressIndicator())));
      }
    );
  }
}