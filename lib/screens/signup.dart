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
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                    'Your Full Name',
                    ),
                    SizedBox(width: 10.0,),
                    Text(
                    'Raphael Tildai',
                    ),
                    SizedBox(height: 20.0,),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                    'Registration number',
                    ),
                    SizedBox(width: 10.0,),
                    Text(
                    'CT201/0005/18',
                    ),
                    SizedBox(height: 20.0,),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                    'Your Department',
                    ),
                    SizedBox(width: 10.0,),
                    Text(
                    'Computer Science',
                    ),
                    SizedBox(height: 20.0,),
                  ],
                ),
              ],
            ),
          ],
        ),
        ),
    );
  }
}