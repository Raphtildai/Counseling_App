import 'dart:ui';

import 'package:flutter/material.dart';

import '../services/cards.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);


  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  // Text controllers
  final _dateTimecontroller = TextEditingController();
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _regnocontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _pnumbercontroller = TextEditingController();

  // Creating date time variable
  DateTime _dateTime = DateTime.now();

  // Choosing date function
  void _showDatePicker () {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2022), 
      lastDate: DateTime(2025),
    ).then((value){
      // Setting the Date time to the value the user picks
      setState(() {
        _dateTime = value!;
      });
    });  
  }

  Future bookSession() async {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Your Session'),
        elevation: 0,
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
                    'Booking Counseling Session.',
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Enter date or choose below',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 14.0,
                        color: Colors.deepPurple.shade500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
          
                // Date Time Pick text field
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
                        controller: _dateTimecontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '$_dateTime',
                        ),
                      ),
                    ),
                  ),
                ),
          
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        highlightColor: Colors.deepPurple[600],
                        padding: EdgeInsets.all(10.0),
                        onPressed: _showDatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            letterSpacing: 1.0,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                      ),
                    ],
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
                      bookSession();
                    },             
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Text(
                          'Book',
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
                SizedBox(height: 100.0,),
              ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}