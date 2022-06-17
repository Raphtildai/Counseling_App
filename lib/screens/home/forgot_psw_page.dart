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
      await FirebaseAuth.instance.sendPasswordResetEmail(
      email: _emailcontroller.text.trim(),
    );

    // Letting the user know that their password reset link has been sent
    showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text('Password Reset link has been sent to your Email.'),
        );
      });

    }on FirebaseAuthException catch(e){
      print(e);

      // Alerting the user on errors which might arise on the app
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/flutter.png'),
                  radius: 40.0,
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
          MaterialButton(
            onPressed: (){
              passWordReset();      
            },
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
            color: Colors.deepPurple,
          ),
        ],
      ),
    );
  }
}