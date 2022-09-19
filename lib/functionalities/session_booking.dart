// ignore_for_file: prefer_const_constructors


import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionBooking extends StatefulWidget {
  const SessionBooking({Key? key}) : super(key: key);


  @override
  State<SessionBooking> createState() => _SessionBookingState();
}

 // creating a list of document IDs
  List <String> docIDs = [];

  // Creating function to retrieve the documents
  Future getdocIDs() async {
    await FirebaseFirestore.instance.collection('bookings').where('counseleeID', isEqualTo: FirebaseAuth.instance.currentUser?.uid).get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        // adding the document to the list
        docIDs.add(document.reference.id);
    }));
  }
class _SessionBookingState extends State<SessionBooking> {
  // Text controllers
  final _dateTimecontroller = TextEditingController();
  final _timecontroller = TextEditingController();
  final _regnocontroller = TextEditingController();

  // hint text to show on the date text field
  String dateHint = 'Date format YYYY-MM-DD'; 
  String timeHint = 'Time format HH:MM';

    // Calling the email of the user that is logged in
  User user = FirebaseAuth.instance.currentUser!;
  // Connecting to firebase
  CollectionReference booking = FirebaseFirestore.instance.collection('bookings');

  // Date
  // Creating date time variable
  DateTime _selectedDate = DateTime.now();
  DateTime _initialDate = DateTime.now();
  DateTime _lastDate = DateTime(2023);

  Future displayDatePicker(BuildContext context) async {

  // Choosing date function
  var date = await showDatePicker(
    context: context, 
    initialDate: _selectedDate, 
    firstDate: _initialDate, 
    lastDate: _lastDate,
  );
  if(date != null){
    setState(() {
      _dateTimecontroller.text = date.toLocal().toString().split(" ")[0];
      dateHint = date.toLocal().toString().split(" ")[0];
    });
  } 
}

  // Time
  // Creating date time variable
  TimeOfDay timeOfDay = TimeOfDay.now();

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(
      context: context, 
      initialTime: timeOfDay, 
    );
    if(time == null){
      return AlertDialog(
        content: SnackBar(content: Text('Time cannot be empty')),
      );
    }else{
      setState(() {
        _timecontroller.text = '${time.hour}:${time.minute}';
      });
    }
  }

  Future bookSession() async{
    try{
      // Loading
      showDialog(
        context: context, 
        builder: (context){
          return Center(child: CircularProgressIndicator());
        }
      );
      // Pop out the loading widget
      Navigator.of(context).pop();

      // Checking whether the user has pending approval
      // CollectionReference approvalRequest = FirebaseFirestore.instance.collection('bookings').where('regnumber', isEqualTo: _regnocontroller).get
      
      // Creating a user with user credential
      bookUser(
        _regnocontroller.text.trim(),
        _dateTimecontroller.text.trim(),
        _timecontroller.text.trim(),
        DateTime.now(),
      );
    }catch(e){
      await showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.toString()),
        );
      });
    } 
  }     
  Future bookUser(String regnumber, String date, String time, DateTime now) async {
    try{
    // Loading
    showDialog(
      context: context, 
      builder: (context){
        return Center(child: CircularProgressIndicator());
      }
    );
    // Pop out the loading widget
    Navigator.of(context).pop();
    //Creating user information with email and registration

    var book = await FirebaseFirestore.instance.collection('bookings').doc(FirebaseAuth.instance.currentUser!.uid).set({
        // Add the user to the collection
        'counselee_email': FirebaseAuth.instance.currentUser?.email,
        'regnumber': regnumber,
        'date_booked': date,
        'time_booked': time,
        'created_at': now, //DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now())
        'approval': 'Pending',
      });

    await showDialog(context: context, builder: (context){
      return const AlertDialog(
        content: Text('Booking Successful'),
      );
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return MainPage();
    }));

    }on FirebaseAuthException catch(e){
        await showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        });
        // Pop out the loading widget
        Navigator.of(context).pop();
      
      }
    }
  
  @override
  void dispose() {
    super.dispose();
    _regnocontroller.dispose();
    _dateTimecontroller.dispose();
    _timecontroller.dispose();
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
                        textCapitalization: TextCapitalization.characters,
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

                // // Reason why you feel you need to talk to the counselor
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: Text(
                //     'Enter reason for booking the appointment',
                //     style: TextStyle(
                //       fontSize: 16,
                //     ),
                //   ),
                // ),

                // SizedBox(height: 10,),

                // // Reason input text field
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.grey[200],
                //       border: Border.all(color: Colors.white),
                //       borderRadius: BorderRadius.circular(25.0),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.only(left: 20.0),
                //       child: TextField(
                //         controller: _reasoncontroller,
                //         keyboardType: TextInputType.multiline,
                //         minLines: 3,
                //         maxLines: null,
                //         decoration: InputDecoration(
                //           border: InputBorder.none,
                //           hintText: 'How do you feel?',
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 10.0,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Enter / Choose Date & Time',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: dateHint,
                        ),
                      ),
                    ),
                  ),
                ),
          
                SizedBox(height: 5.0,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        highlightColor: Colors.deepPurple[600],
                        color: Colors.deepPurple[400],
                        padding: EdgeInsets.all(10.0),
                        onPressed: () => displayDatePicker(context),
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            color: Colors.white,
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

                // TimePicker field
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
                        controller: _timecontroller,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: timeHint,
                        ),
                      ),
                    ),
                  ),
                ),
          
                SizedBox(height: 5.0,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        highlightColor: Colors.deepPurple[600],
                        color: Colors.deepPurple[400],
                        padding: EdgeInsets.all(10.0),
                        onPressed: () => displayTimePicker(context),
                        child: Text(
                          'Choose Time',
                          style: TextStyle(
                            color: Colors.white,
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
          
                // Button to submit bookings
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
                          'Book Session',
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