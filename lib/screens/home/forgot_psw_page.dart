// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//  forgot password emailcontroller
final _emailcontroller = TextEditingController();

// disposing the controller
@override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  // function to fetch and send password reset
  Future passWordReset() async {
    // Try or catch errors thrown from firebase
    try{
      // Show circular loading while waiting for data
      showDialog(
        context: context, 
        builder: (context){
          return Center(child: CircularProgressIndicator());
        }
      );
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailcontroller.text.trim(),
      );

      // Popping out the loading
      Navigator.of(context).pop();

      // Letting the user know that their password reset link has been sent
      await showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text('Password Reset link has been sent to your Email.'),
          );
        });

    }on FirebaseAuthException catch(e){
      // Alerting the user on errors which might arise on the app
      await showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }

    // Popping out the loading
    Navigator.of(context).pop();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Reset Your Password'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/logo1.png'),
                    radius: 100.0,
                  ),
                ),
            
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Enter Your email and we will send you a Password reset link via Email',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    ),
                ),
                SizedBox(height: 10.0,),
            
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
                          hintText: 'Enter Registered Email Address',
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
                SizedBox(height: 10.0,),
                MaterialButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      passWordReset();
                    }      
                  },
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
          
                SizedBox(height: 40.0,),
          
                // // Show login page if the user remembers the password
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Remember Password?',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       ),
                //       ),
                //     SizedBox(width: 10.0,),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(context, MaterialPageRoute(builder: (context){
                //             return LoginPage(ShowRegisterPage: );
                //         },),);
                //       },
                //       child: Text(
                //         'Login to your account',
                //         style: TextStyle(
                //           color: Colors.blue,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}