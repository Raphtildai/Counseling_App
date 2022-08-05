// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously

import 'package:careapp/screens/authenticate/auth.dart';
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
        _regnocontroller.text.trim(),
        _emailcontroller.text.trim(),
        _passwordcontroller.text.trim(),
        int.parse(_pnumbercontroller.text.toString()),
      );

      showDialog(context: context, builder: (context){
        return const AlertDialog(
          content: Text('Registration Successful'),
        );
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return const AuthPage();
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
  Future addUserDetails(String fname, String lname, String regno, String email, String password, int pnumber) async {
    await FirebaseFirestore.instance.collection('users').add({
      // We pass the above parameters inform of a map
      'firstname': fname,
      'lastname': lname,
      'regnumber': regno,
      'email': email,
      'password': password,
      'pnumber': pnumber,
      'role': "counselee",
      'date_registered': DateTime.now(),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/flutter.png'),
                    radius: 30.0,
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
                      child: TextField(
                        controller: _firstnamecontroller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First Name',
                        ),
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
                      child: TextField(
                        controller: _lastnamecontroller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Last Name',
                        ),
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
                      child: TextField(
                        controller: _regnocontroller,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Registration Number',
                        ),
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
                      child: TextField(
                        controller: _emailcontroller,
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
                        keyboardType: TextInputType.number,
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
          
                // sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(    
                    onTap: (){
                      signingUp();
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
        const SizedBox(height: 100.0,),
        ],
      ),
    );
  }
}