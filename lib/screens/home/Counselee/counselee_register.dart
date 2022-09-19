import 'package:careapp/screens/home/Counselee/counselee_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CounseleeRegister extends StatefulWidget {
  const CounseleeRegister({ Key? key }) : super(key: key);

  @override
  _CounseleeRegisterState createState() => _CounseleeRegisterState();
}

const heading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

class _CounseleeRegisterState extends State<CounseleeRegister> {
  String Validate(String value){
    if(value == null || value == ""){
      return 'This field cannot be empty';
    }else{
       return value;
    }
  } 
  // Text controllers
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _pnumbercontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _aboutcontroller = TextEditingController();
  final _regnumbercontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _schoolcontroller = TextEditingController();
  final _coursecontroller = TextEditingController();
  final _year_of_studycontroller = TextEditingController();
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
      _regnumbercontroller.text.trim(),
      int.parse(_agecontroller.text.toString()),
      _schoolcontroller.text.trim(),
      _coursecontroller.text.trim(),
      int.parse(_year_of_studycontroller.text.toString()),
    );

    await showDialog(context: context, builder: (context){
      return const AlertDialog(
        content: Text('Registration Successful'),
      );
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return CounseleeList();
    }));
  }on FirebaseAuthException catch(e){
    if (e.code == 'weak-password') {
      await showDialog(context: context, builder: (context){
        return const AlertDialog(
          content: Text('The password provided is too weak.'),
        );
      });
    } else if (e.code == 'email-already-in-use') {
      await showDialog(context: context, builder: (context){
        return const AlertDialog(
          content: const Text('The account already exists for that email.'),
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
Future addUserDetails(String fname, String lname, String email, int pnumber, String password, String about, String regnumber, int age, String school, String course, int year_of_study) async {
  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
    // We pass the above parameters inform of a map
    'firstname': fname,
    'lastname': lname,
    'email': email,
    'pnumber': pnumber,
    'password': password,
    'about': about,
    'regnumber': regnumber,
    'age': age,
    'school': school,
    'Course': course,
    'year_of_study': year_of_study,
    'role': "counselee",
    'date_CounseleeRegistered': DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now()),

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
    _regnumbercontroller.dispose();
    _agecontroller.dispose();
    _schoolcontroller.dispose();
    _coursecontroller.dispose();
    _year_of_studycontroller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counselee Registration',),
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
                child: Text('Counselee\'s Basic Details', style: heading,),
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
                          }else if(!text.contains(RegExp(r'[a-z]+@students.must.ac.ke'))){
                            return 'Enter valid Student email';
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
        
                // Age
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
                        controller: _agecontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Age',
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'This field is required';
                          }else if(int.parse(text) < 0 || int.parse(text) > 50){
                            return 'Please enter realistic age for a student';
                          }else if(text.contains(RegExp(r'[A-Za-z-]'))){
                            return 'Only figures allowed';
                          }return null;
                        },
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),
        
                // Education Details
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text('Education Details', style: heading,),
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
                        controller: _regnumbercontroller,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Registration Number',
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'Registration Number field is empty';
                          }else if(text.length < 2 || text.length > 15){
                            return 'Registration Number is not Valid';
                          }else if(!text.contains(RegExp(r'[0-9]'))){
                            return 'Should Contain numbers';
                          }else if(!text.contains(RegExp(r'[A-Z]'))){
                            return 'Should Contain Characters';
                          }else if(!text.contains(RegExp(r'[A-Za-z]+[0-9]+/+[0-9]+/+[1-9]'))){
                            return 'Enter Valid Registration Number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),
        
                // school
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
                        controller: _schoolcontroller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'School',
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'This Field is Required';
                          }else if(text.contains(RegExp(r'[0-9]'))){
                            return 'Only Character letters allowed';
                          }return null;
                        },
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),
        
                // Course
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
                        controller: _coursecontroller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Course',
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'This Field is Required';
                          }else if(text.contains(RegExp(r'[0-9]'))){
                            return 'Only Character letters allowed';
                          }return null;
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
                        controller: _year_of_studycontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Year of Study',
                        ),
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return 'This field is required';
                          }else if(int.parse(text) < 1 || int.parse(text) > 4){
                            return 'Please enter correct year of study i.e 4';
                          }else if(text.contains(RegExp(r'[A-Za-z]'))){
                            return 'Only figures allowed';
                          }return null;
                        },
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10.0,),
        
              
              // CounseleeRegister button
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
                          'Register Counselee',
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