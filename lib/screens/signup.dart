import 'dart:html';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: SignUp(),
  ));
}

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Sign up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/flutter.png'),
                radius: 40.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.grey[400],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: TextField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                  icon: Icon(Icons.abc),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
              child: TextField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                  icon: Icon(Icons.mail),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
              child: TextField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Registration Number',
                  icon: Icon(Icons.numbers),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
              child: TextField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Course',
                  icon: Icon(Icons.abc),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Password',
                  icon: Icon(Icons.password),
                ),
                autocorrect: false,
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton.icon(
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/login');
                    }, 
                    icon: Icon(Icons.app_registration),
                    label: Text('Registration'),
                    ),
                ),
                SizedBox(width: 20.0,),
                Center(
              child: ElevatedButton.icon(
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed('/home');
                }, 
                icon: Icon(Icons.login),
                label: Text('Login'),
                ),
            ),
              ],
            ),
          ],
        ),
      ),
              
    );
  }
}