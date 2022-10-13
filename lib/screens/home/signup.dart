// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously

import 'package:careapp/models/auth_service.dart';
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// void main(List<String> args) {
//   runApp(MaterialApp(
//     home: SignUp(ShowLoginPage: ShowLoginPage),
//   ));
// }

class SignUp extends StatefulWidget {
  final ShowLoginPage;
  const SignUp({Key? key, required this.ShowLoginPage}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Text controllers
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _regnocontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _pnumbercontroller = TextEditingController();
  final _admissioncontroller = TextEditingController();
  bool passwordVisible = false;

  // // Function to choose the year
  // Future chooseYear() async {
  //   await showYearPicker()
  // }

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
        _regnocontroller.text.trim(),
        _emailcontroller.text.trim(),
        _passwordcontroller.text.trim(),
        int.parse(_pnumbercontroller.text.toString()),
        _admissioncontroller.text.toString(),
        DateTime.now()
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
  Future addUserDetails(String fname, String lname, String regno, String email, String password, int pnumber, String year, DateTime now) async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      // We pass the above parameters inform of a map
      'firstname': fname,
      'lastname': lname,
      'regnumber': regno,
      'email': email,
      'password': password,
      'pnumber': pnumber,
      'Year_of_admission': year,
      'role': "counselee",
      'date_registered': now,//DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now())
    });
  }

  // we dispose the above controllers to help our memory management
  @override
  void dispose() {
    _firstnamecontroller.dispose();
    _lastnamecontroller.dispose();
    _regnocontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _pnumbercontroller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('sign Up Page'),
        centerTitle: true,
      ),
      body: ListView(
        children: [

          Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
      
          // SingleChildScrollView removes the overflow
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/logo1.png'),
                      radius: 50.0,
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  // Text to display at the top
                  const Center(
                    child: Text(
                      'Welcome to Counseling App.',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Divider(
                    height: 60.0,
                    color: Colors.grey[400],
                  ),
                      
                  // First Name Text field
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
                          controller: _firstnamecontroller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'First Name',
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
                  
                  const SizedBox(height: 10.0,),
                  
                  // Last Name Text field
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
                          controller: _lastnamecontroller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Last Name',
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
                  
                  const SizedBox(height: 10.0,),
                  
                  // Reg number text field
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
                          controller: _regnocontroller,
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
                            }else if(!text.contains(RegExp(r'[A-Z]+[0-9]+/+[0-9]+/+[1-9]'))){
                              return 'Enter Valid Registration Number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10.0,),
                      
                  // email text field
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
                              return 'Enter your valid Student email';
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
                          keyboardType: TextInputType.number,
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
            
                  // Year of admission
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
                          controller: _admissioncontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Year Admitted to University',
                          ),
                          validator: (text){
                            if(text == null || text.isEmpty){
                              return 'Year admitted field is empty';
                            }else if(text.length < 4 || text.length > 4){
                              return 'Year admitted is not Valid';
                            }else if(text.contains(RegExp(r'[A-Z]')) || text.contains(RegExp(r'[a-z]'))){
                              return 'Only Digits allowed';
                            }else if(text.contains(RegExp(r'[!@#$%^&*()"|:;,.?=~`]_/-]'))){
                              return 'Invalid characters';
                            }else if(!text.contains(RegExp(r'[0-9]'))){
                              return 'Should Contain numbers';
                            }else if(int.parse(text) > DateTime.now().year || int.parse(text) < DateTime(2011).year){
                              return 'Year not within range';
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
                      
                  // sign up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(    
                      onTap: (){
                        if(_formKey.currentState!.validate()){

                          // AuthenticationService().createUser(_firstnamecontroller.text, _emailcontroller.text, _passwordcontroller.text);
                          signingUp();
                        }
                      },             
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign Up',
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
                      
                   const SizedBox(height: 15.0,),
                      
                  // Register button if not a member
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have account?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      const SizedBox(width: 10.0,),
                      GestureDetector(
                        onTap: () {
                          widget.ShowLoginPage();
                        },
                        child: const Text(
                          'Login Now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                      
                  // Center(
                  //   child: Container(
                      
                  //     child: ElevatedButton.icon(
                  //       onPressed: (){
                  //         signIn();
                  //         // Navigator.of(context).pushReplacementNamed('/home');
                  //       }, 
                  //       icon: Icon(Icons.login),
                  //       label: Text('Login'),
                  //       ),
                  //   ),
                    
                  
                  // ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 100.0,),
        ],
      ),
    );
  }
}