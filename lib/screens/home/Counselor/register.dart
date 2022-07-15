// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

const heading = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  String Validate(String value){
    if(value == null || value == ""){
      return 'This field cannot be empty';
    }else{
       return value;
    }
  }

class _RegisterState extends State<Register> {
    // Calling the email of the user that is logged in
  User user = FirebaseAuth.instance.currentUser!;
  // Connecting to firebase
  CollectionReference booking = FirebaseFirestore.instance.collection('bookings');

  // Function to add the booking to the database
  Future<void> addBooking(){
    // Calling the collection to add counselee booking
    return booking.add({
      // Data added in the form of a dictionary into the document

      
    });

  }

  // Form key
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counselor Registration',),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10,),
              // Basic Details
              const Text('Counselor\'s Basic Details', style: heading,),

              const SizedBox(height: 10,),
              // Full Names
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        border: InputBorder.none
                        
                      ),
                      
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              // Phone Number text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        // controller: _pnumbercontroller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                        ),
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),

                // Email Address
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        // controller: _pnumbercontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email Address',
                        ),
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),

                // password text field
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        // controller: _passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),

                // Professional Details
                const Text('Professional Details', style: heading,),

                const SizedBox(height: 10),

                // Counselor ID
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        // controller: _pnumbercontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Counselor ID',
                        ),
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),

                // Profession
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        // controller: _pnumbercontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Profession',
                        ),
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),

                // Experience
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        // controller: _pnumbercontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Years of Experience',
                        ),
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),

      
              // Register button
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(    
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Center(child: CircularProgressIndicator()),
                          ),
                        );
                      }
                    },             
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Register',
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
              ),
            ],
          ),       
        ),
      ),
    );
  }
}