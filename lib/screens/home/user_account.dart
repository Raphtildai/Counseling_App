// ignore_for_file: camel_case_types, prefer_final_fields, annotate_overrides, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAccount extends StatefulWidget {

const UserAccount({ Key? key }) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
final FirebaseAuth auth = FirebaseAuth.instance;
@override
  Widget build(BuildContext context){
    final userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference userData = FirebaseFirestore.instance.collection('users');
    const headingStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    const textStyle = TextStyle(
      fontSize: 14,
    );
    return FutureBuilder <DocumentSnapshot>(
      future: userData.doc(userId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        // Error handling conditions
        if(snapshot.hasError){
          return const Center(child: Text('Something went Wrong'));
        }
        if(snapshot.hasData && !snapshot.data!.exists){
          return const Center(child: Text('Your Account information could not be found'),);
        }
        //Outputting the data to the user if the connection is done
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Text('${data['firstname']} ' '${data['lastname']}\'s Profile '),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Account profile picture
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Container(
                        // height: MediaQuery.of(context).size.height - 200,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(height: 20,),
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              child: Image.asset(
                                'assets/raph.PNG',
                                // height: 100,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(
                                  Icons.edit,
                                ),
                                // const SizedBox(width: 10,),
                                const Text('Change Account Picture'),
                              ],
                            ),
                            const SizedBox(height: 10,),
                          ],
                        ),
                        
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text('Personal Information', style: headingStyle,),
                          const Text('This is what others will see on your Counseling profile.', style: textStyle,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
              
                    // Name and basic details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(height: 10,),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // Name
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Name', style: headingStyle,),
                                // const SizedBox(width: 5,),
                                Text('${data['firstname'] +' ' + data['lastname']}', style: textStyle,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // Email address
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Email', style: headingStyle,),
                                // const SizedBox(width: 5,),
                                Text('${data['email']}', style: textStyle,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // Phone number
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Phone Number', style: headingStyle,),
                                // const SizedBox(width: 5,),
                                Text('${data['pnumber']}', style: textStyle,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            //Reg number
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Registration Number', style: headingStyle,),
                                // const SizedBox(width: 5,),
                                Text('${data['regnumber']}', style: textStyle,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // About
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('About', style: headingStyle,),
                                // const SizedBox(width: 5,),
                                Text('${data['about']}', style: textStyle,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ],
                        ),
                        
                      ),
                    ),
                    
                    // Education Details
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text('Your Education Details', style: headingStyle,),
                          const Text('This shows the school and the course you are enrolled at.', style: textStyle,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(height: 10,),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // School
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('School', style: headingStyle,),
                                // const SizedBox(width: 5,),
                                Text('${data['school']}', style: textStyle,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                            // Course
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Course', style: headingStyle,),
                                // const SizedBox(width: 5,),
                                Text('${data['Course']}', style: textStyle,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            const Divider(
                              height: 20,
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    // Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: GestureDetector(    
                        onTap: (){
                        },             
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Edit Your Profile',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        // Return loading to the user
        return Scaffold(
          body: const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.deepPurple,
            ),
          ),
        );
      },
    );     
  }
}