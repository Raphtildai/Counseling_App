// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, unnecessary_null_comparison

import 'package:careapp/screens/authenticate/auth.dart';
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/screens/home/Counselor/counselor_list.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CounselorRegister extends StatefulWidget {
  const CounselorRegister({ Key? key }) : super(key: key);

  @override
  _CounselorRegisterState createState() => _CounselorRegisterState();
}

const heading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

class _CounselorRegisterState extends State<CounselorRegister> { 
  // Text controllers
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _pnumbercontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _aboutcontroller = TextEditingController();
  final _counselorIDcontroller = TextEditingController();
  final _professioncontroller = TextEditingController();
  final _ratingcontroller = TextEditingController();
  bool passwordVisible = false;

  // Sign up function
  Future signingUp() async{
    try{
      // Loading
      showDialog(
        context: context, 
        builder: (context){
          return const Center(child: CircularProgressIndicator());
        }
      );
      // Pop out the loading widget
      Navigator.of(context).pop();
      // Create User using the email and password
      // This allows the user to create user using email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim(),
      );

      // adding user details by calling the function
      addUserDetails(
        _firstnamecontroller.text.trim(),
        _lastnamecontroller.text.trim(),
        _emailcontroller.text.trim(),
        int.parse(_pnumbercontroller.text.toString()),
        _passwordcontroller.text.trim(),
        _aboutcontroller.text.trim(),
        _counselorIDcontroller.text.trim(),
        _professioncontroller.text.trim(),
        int.parse(_ratingcontroller.text.toString()),
      );

      await showDialog(context: context, builder: (context){
        return const AlertDialog(
          content: Text('Registration Successful'),
        );
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return MainPage();
      }));
    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        await showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text('The password provided is too weak.'),
          );
        });
      } else if (e.code == 'email-already-in-use') {
        await showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text('The account already exists for that email.'),
          );
        });
      }else{
        await showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        });
        // Pop out the loading widget
        Navigator.of(context).pop();
      }
    }
}

// function to add user details
// We will pass the above controllers to the function
Future addUserDetails(String fname, String lname, String email, int pnumber, String password, String about, String counselorID, String profession, int rating) async {
  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
    // We pass the above parameters inform of a map
    'firstname': fname,
    'lastname': lname,
    'email': email,
    'pnumber': pnumber,
    'password': password,
    'about': about,
    'counselorID': counselorID,
    'profession': profession,
    'rating': rating,
    'role': "counselor",
    'date_CounselorRegistered': DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now()),
    // 'uid': FirebaseAuth.instance.currentUser!.uid,
  });
    
  }

  // we dispose the above controllers to help our memory management
  @override
  void dispose() {
    _firstnamecontroller.dispose();
    _lastnamecontroller.dispose();
    _emailcontroller.dispose();
    _pnumbercontroller.dispose();
    _passwordcontroller.dispose();
    _aboutcontroller.dispose();
    _counselorIDcontroller.dispose();
    _professioncontroller.dispose();
    _ratingcontroller.dispose();
    super.dispose();
  }
  
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10,),
              // Basic Details
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text('Counselor\'s Basic Details', style: heading,),
              ),
        
              const SizedBox(height: 10,),
        
              // First Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: _firstnamecontroller,
                      decoration: const InputDecoration(
                        hintText: 'First name',
                        border: InputBorder.none
                      ),
                      validator: (text){
                        if(text == null || text.isEmpty){
                          return 'First Name field is empty';
                        }else if(text.length < 2 || text.length > 20){
                          return 'Name is not Valid';
                        }else if(text.contains(RegExp(r'[0-9]'))){
                          return 'Name Should not Contain numbers';
                        }
                        return null;
                      },                      
                    ),
                  ),
                ),
              ),
        
              const SizedBox(height: 10,),
        
              // Last name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: _lastnamecontroller,
                      decoration: const InputDecoration(
                        hintText: 'Last name',
                        border: InputBorder.none
                      ),
                      validator: (text){
                        if(text == null || text.isEmpty){
                          return 'Last Name field is empty';
                        }else if(text.length < 2 || text.length > 20){
                          return 'Name is not Valid';
                        }else if(text.contains(RegExp(r'[0-9]'))){
                          return 'Name Should not Contain numbers';
                        }
                        return null;
                      },                      
                    ),
                  ),
                ),
              ),
        
              const SizedBox(height: 10,),
        
                // Email Address
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email Address',
                        ),
                        validator: (text){
                          // RegExp('[0-9]+@students.kcau.ac.ke');
                          if(text == null || text.isEmpty){
                            return 'Email address field is empty';
                          }else if(text.length < 2 || text.length > 40){
                            return 'Email address is not Valid';
                          }else if(text.contains(RegExp(r'[0-9]'))){
                            return 'Email Should not Contain numbers';
                          }else if(!text.contains(RegExp(r'[a-z]+@staff.must.ac.ke'))){
                            return 'Enter valid Staff email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),
        
              // Phone Number text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _pnumbercontroller,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'Phone Number field is empty';
                          }else if(!text.contains(RegExp(r'[0-9]'))){
                            return 'Should Contain numbers';
                          }else if(text.contains(RegExp(r'[A-Z]')) || text.contains(RegExp(r'[a-z]'))){
                            return 'Phone no. cannot contain characters';
                          }else if(text.contains(RegExp(r'[!@#$%^&*()_"|:;,.?=~\`-]'))){
                            return 'Invalid characters';
                          }else if(text.length != 10){
                            return 'Phone no. Digits should be 10 characters';
                          }
                          return null;
                        },
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _passwordcontroller,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                passwordVisible = !passwordVisible;                                
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(13),
                              child: Icon(
                                passwordVisible
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye_sharp,
                                color: Colors.deepPurple,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'Password Cannot be Empty';
                          }else if(text.length < 6){
                            return 'Password Length Should be at least 6 characters';
                          }return null;
                        },
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),
        
                // About
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _aboutcontroller,
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'About',
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'Please Write Something!!';
                          }return null;
                        },
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),
        
                // Professional Details
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text('Professional Details', style: heading,),
                ),
        
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _counselorIDcontroller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Counselor ID',
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'This Field is Required';
                          }else if(text.length != 7){
                            return 'Counselor ID length is 7';
                          }else if(!text.contains(RegExp(r'CRT+[0-9]'))){
                            return 'Counselor ID is like CRT2001';
                          }return null;
                        },
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _professioncontroller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Profession',
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'Profession field is empty';
                          }else if(text.length < 2 || text.length > 20){
                            return 'Profession field is not Valid';
                          }else if(text.contains(RegExp(r'[0-9]'))){
                            return 'Profession Should not Contain numbers';
                          }
                          return null;
                        },
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _ratingcontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Years of Experience',
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'This field is required';
                          }else if(int.parse(text) < 0 || int.parse(text) > 70){
                            return 'Please enter realistic figures';
                          }else if(text.contains(RegExp(r'[A-Za-z]'))){
                            return 'Only figures allowed';
                          }return null;
                        },
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),
        
              
              // CounselorRegister button
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(    
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        signingUp();
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
                          'Register Counselor',
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
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}