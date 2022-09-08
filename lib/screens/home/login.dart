// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgot_psw_page.dart';

class LoginPage extends StatefulWidget {
  // calling the register page
  final VoidCallback ShowRegisterPage;
  const LoginPage({Key? key, required this.ShowRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Text controllers
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  // Sign in function
  Future signIn() async{
    
      try{
        // Show circular loading while waiting for data
    showDialog(
      context: context, 
      builder: (context){
        return Center(child: CircularProgressIndicator());
      }
      );
        // This allows the user to login using email and password
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailcontroller.text.trim(), 
          password: _passwordcontroller.text.trim(),  
        );

        // Popping out the loading
          Navigator.of(context).pop();
          
        // Telling the user that sign in was successful
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text('Login success'),
            );
          }); 
        
      }on FirebaseAuthException catch(e){
        // print(e);
        if (e.code == 'user-not-found') {
          return AlertDialog(
            content: Text('This email is not registered'),
          );
          // print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          return AlertDialog(
            content: Text('You\'ve entered the wrong password for that user'),
          );
          // print('Wrong password provided for that user.');
        }else{
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
        }
      }
  }

  // we dispose the above controllers to help our memory management
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),

        // SingleChildScrollView removes the overflow
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/flutter.png'),
                  radius: 40.0,
                ),
              ),
              SizedBox(height: 20.0,),
              // Text to display at the top
              Center(
                child: Text(
                  'Hello! and Welcome',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Divider(
                height: 60.0,
                color: Colors.grey[400],
              ),
        
              // email text field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email Address',
                      ),
                    ),
                  ),
                ),
              ),
        
              SizedBox(height: 20.0,),
        
              // password text field
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.0,),

              // forgot password text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ForgotPasswordPage();
                        },),);
                      },
                        

                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: 20.0,),
        
              // sign in button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(    
                  onTap: (){
                    signIn();
                  },             
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Center(
                      child: Text(
                        'Sign in',
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
        
               SizedBox(height: 25.0,),
        
              // Register button if not a member
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a Member?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  SizedBox(width: 10.0,),
                  GestureDetector(
                    onTap: () {
                      widget.ShowRegisterPage();
                    },
                    child: Text(
                      'Register Now',
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
    );
  }
}