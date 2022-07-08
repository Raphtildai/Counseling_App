import 'package:careapp/screens/authenticate/auth.dart';
import 'package:careapp/screens/home/login.dart';
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

  // Sign in function
  Future signingUp() async{
    try{
      // Loading
      showDialog(
        context: context, 
        builder: (context){
          return Center(
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
        return AlertDialog(
          content: Text('Registration Successful'),
        );
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return AuthPage();
      }));
    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return AlertDialog(
          content: Text('The password provided is too weak.'),
        );
      } else if (e.code == 'email-already-in-use') {
        return AlertDialog(
          content: Text('The account already exists for that email.'),
        );
      }else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
          // Pop out the loading widget
          Navigator.of(context).pop();
        });
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
        title: Text('sign Up Page'),
        centerTitle: true,
      ),
      body: ListView(
        children: [

          Padding(
          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
      
          // SingleChildScrollView removes the overflow
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/flutter.png'),
                    radius: 30.0,
                  ),
                ),
                SizedBox(height: 10.0,),
                // Text to display at the top
                Center(
                  child: Text(
                    'Welcome to Ment Care.',
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
                        controller: _firstnamecontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First Name',
                        ),
                      ),
                    ),
                  ),
                ),
      
                SizedBox(height: 10.0,),
      
                // Last Name Text field
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
                        controller: _lastnamecontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Last Name',
                        ),
                      ),
                    ),
                  ),
                ),
      
                SizedBox(height: 10.0,),
      
                // Reg number text field
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
                        controller: _regnocontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Registration Number',
                        ),
                      ),
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
          
                SizedBox(height: 10.0,),
      
                // Phone Number text field
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
                        controller: _pnumbercontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                        ),
                      ),
                    ),
                  ),
                ),
          
                SizedBox(height: 10.0,),
          
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
          
                // sign in button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(    
                    onTap: (){
                      signingUp();
                    },             
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
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
          
                 SizedBox(height: 15.0,),
          
                // Register button if not a member
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have account?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    SizedBox(width: 10.0,),
                    GestureDetector(
                      onTap: () {
                        widget.ShowLoginPage();
                      },
                      child: Text(
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
        SizedBox(height: 100.0,),
        ],
      ),
    );
  }
}