// ignore_for_file: prefer_const_constructors


import 'package:careapp/functionalities/calendar/calendar_page.dart';
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
  String dateHint = 'Choose date'; 
  String timeHint = 'choose time';

    // Calling the email of the user that is logged in
  User user = FirebaseAuth.instance.currentUser!;
  // Connecting to firebase
  CollectionReference booking = FirebaseFirestore.instance.collection('bookings');

  // Initial date and time Date
  DateTime day_time = DateTime.now();
  // Creating date time variable
  final DateTime _selectedDate = DateTime.now();
  final DateTime _initialDate = DateTime.now();
  final DateTime _lastDate = DateTime(2023);

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
      day_time = DateTime(
        date.year,
        date.month,
        date.day,
        day_time.hour,
        day_time.minute,
      );
    });
  } 
}

  // Creating date time variable
  TimeOfDay timeOfDay = TimeOfDay.now();

  // Time Function to show date picker
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
        timeHint = '${time.hour}:${time.minute}';
        _timecontroller.text = '${time.hour}:${time.minute}';
        day_time = DateTime(
          day_time.year,
          day_time.month,
          day_time.minute,
          time.hour,
          time.minute,
        );
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

      bookUser(
        DateTime.parse(_dateTimecontroller.text.trim()),
        _timecontroller.text.trim(),
        DateTime.now(),
        day_time,
      );
    }catch(e){
      await showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.toString()),
        );
      });
    } 
  }     
  Future bookUser(DateTime date, String time, DateTime now, DateTime day_time) async {
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
        'date_booked': date,
        'time_booked': time,
        'created_at': now, //DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now())
        'approval': 'Pending',
        'date_time_booked': day_time,
      });

    await showDialog(context: context, builder: (context){
      return const AlertDialog(
        content: Text('Booking Done Successfully'),
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

  final _formKey = GlobalKey<FormState>();
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

                  SizedBox(height: 10.0,),
            
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Choose Date & Time to book',
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

                  // Button to ask the Counselee check Counselor Schedule
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          highlightColor: Colors.deepPurple[600],
                          color: Colors.deepPurple,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CalendarPage()));
                          },
                          child: Text(
                            'Counselor\'s Calendar',
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
                        child: TextFormField(
                          onTap: () => displayDatePicker(context),
                          readOnly: true,
                          controller: _dateTimecontroller,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: dateHint,
                          ),
                          validator: ((value) {
                            if(value == null || value.isEmpty){
                              return 'Date Cannot be empty';
                            }else if(value.length < 10 || value.length > 10){
                              return 'Enter date in the given format';
                            }return null;
                          }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
            
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
                        child: TextFormField(
                          onTap: () => displayTimePicker(context),
                          readOnly: true,
                          controller: _timecontroller,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: timeHint,
                          ),
                          validator: ((value) {
                            if(value == null || value.isEmpty){
                              return 'Time Cannot be empty';
                            }else if(value.length < 4 || value.length > 5){
                              return 'Enter time in the given format';
                            }return null;
                          }),
                        ),
                      ),
                    ),
                  ),
                      
                  SizedBox(height: 20.0,),
            
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       MaterialButton(
                  //         highlightColor: Colors.deepPurple[600],
                  //         color: Colors.deepPurple,
                  //         padding: EdgeInsets.all(10.0),
                  //         onPressed: () => displayDatePicker(context),
                  //         child: Text(
                  //           'Date',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             letterSpacing: 1.0,
                  //             fontSize: 18.0,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                      
                  SizedBox(height: 20.0,),
                      
                  // Button to submit bookings
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(    
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          bookSession();
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
          ),
        ],
      ),
    );
  }
}