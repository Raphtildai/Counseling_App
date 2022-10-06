// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'package:careapp/screens/authenticate/authentication.dart';
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
  bool passwordVisible = false;

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
        await showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text('Login successful'),
          );
        }); 
        
      }on FirebaseAuthException catch(e){
        // print(e);
        if (e.code == 'user-not-found') {
          await showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text('This email is not registered'),
            );
          });
        } else if (e.code == 'wrong-password') {
          await showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text('You\'ve entered the wrong password for that user'),
            );
          });
        }else{
          await showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
        }
      }
      // Popping out the loading
      Navigator.of(context).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      //   return MainPage();
      // },),);
      return MainPage();
  }

  // we dispose the above controllers to help our memory management
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/logo1.png'),
                    radius: 70.0,
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
                      child: TextFormField(
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email Address',
                        ),
                        validator: (text){
                          // RegExp('[0-9]+@students.kcau.ac.ke');
                          if(text == null || text.isEmpty){
                            return 'Email address field is empty';
                          }else if(text.length < 2 || text.length > 40){
                            return 'Email address is not Valid';
                          }
                          // else if(text.contains(RegExp(r'[0-9]'))){
                          //   return 'Email Should not Contain numbers';
                          // }
                          
                          else if(!(text.contains(RegExp(r'[a-z]+@students.must.ac.ke')) || text.contains(RegExp(r'[a-z]+@staff.must.ac.ke')) || text.contains(RegExp(r'[a-z0-9]+@gmail.com')))){
                            return 'Enter valid Student or Staff email';
                          }
                          return null;
                        },
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
                      if(_formKey.currentState!.validate()){
                        signIn();
                      }
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
      ),
    );
  }
}