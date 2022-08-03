import 'package:careapp/screens/home/Counselee/counselee_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

const heading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

class _RegisterState extends State<Register> {
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

  // Sign up function
  Future signingUp() async{
    try{
    // Loading
    showDialog(
      context: context, 
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
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

    showDialog(context: context, builder: (context){
      return const AlertDialog(
        content: Text('Registration Successful'),
      );
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return CounseleeList();
    }));
  }on FirebaseAuthException catch(e){
    if (e.code == 'weak-password') {
      return const AlertDialog(
        content: Text('The password provided is too weak.'),
      );
    } else if (e.code == 'email-already-in-use') {
      return const AlertDialog(
        content: Text('The account already exists for that email.'),
      );
    }else{
      showDialog(context: context, builder: (context){
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
  await FirebaseFirestore.instance.collection('users').add({
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
    'date_registered': DateTime.now(),

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counselee Registration',),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
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
                  child: TextField(
                    controller: _firstnamecontroller,
                    decoration: const InputDecoration(
                      hintText: 'First name',
                      border: InputBorder.none
                    ),                      
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
                  child: TextField(
                    controller: _lastnamecontroller,
                    decoration: const InputDecoration(
                      hintText: 'Last name',
                      border: InputBorder.none
                    ),                      
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
                    child: TextField(
                      controller: _emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email Address',
                      ),
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
                    child: TextField(
                      controller: _pnumbercontroller,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number',
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
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
                    child: TextField(
                      controller: _aboutcontroller,
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'About',
                      ),
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
                    child: TextField(
                      controller: _agecontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Age',
                      ),
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
                    child: TextField(
                      controller: _regnumbercontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Registration Number',
                      ),
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
                    child: TextField(
                      controller: _schoolcontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'School',
                      ),
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
                    child: TextField(
                      controller: _coursecontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Course',
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _year_of_studycontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Year of Study',
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
                      signingUp();
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
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}