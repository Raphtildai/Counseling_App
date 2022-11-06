import 'package:careapp/functionalities/calendar/calendar_page.dart';
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/screens/home/Counselor/approve_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Reschedule extends StatefulWidget {
  static const titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const textStyle = TextStyle(
    fontSize: 14,
  );

  final String date_booked;
  final String time_booked;
  final String created_at;
  final String counselor_email;
  final String docID;

const Reschedule({ 
    Key? key,
    required this.date_booked,
    required this.time_booked,
    required this.created_at, 
    required this.counselor_email,
    required this.docID
  }) : super(key: key);

  @override
  State<Reschedule> createState() => _RescheduleState();
}

// creating a list of document IDs
List <String> docIDs = [];

// Creating function to retrieve the documents
  Future getdocIDs() async {
    await FirebaseFirestore.instance.collection('bookings').where('counseleeID', isEqualTo: '$counseleeID').get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        // adding the document to the list
        docIDs.add(document.reference.id);
    }));
  }

 DateTime datepicked = DateTime.now();
 TimeOfDay timepicked = TimeOfDay.now();
class _RescheduleState extends State<Reschedule> {
// Declaration of controllers
final _dateController = TextEditingController();
final _timecontroller = TextEditingController();
final _reasoncontroller = TextEditingController();

  String DateHint = 'Choose date';
  String TimeHint = 'Choose time';
  String reason = 'Reason';

  // Date rescheduled to 
  DateTime date_time_rescheduled_to = DateTime.now();
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
      final newDate = DateTime(
        date.year,
        date.month,
        date.day,
        date_time_rescheduled_to.hour,
        date_time_rescheduled_to.minute
      );
    setState(() {
      _dateController.text = date.toLocal().toString().split(" ")[0];
      date_time_rescheduled_to = newDate;
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
      return const AlertDialog(
        content: SnackBar(content: Text('Time cannot be empty')),
      );
    }else{
        final newDate = DateTime(
          date_time_rescheduled_to.year,
          date_time_rescheduled_to.month,
          date_time_rescheduled_to.day,
          time.hour,
          time.minute,
        );
      setState(() {
        _timecontroller.text = '${time.hour}:${time.minute}';
        date_time_rescheduled_to = newDate;
      });
    }
  }
  
  
// Disposing the values of the controllers
@override
  void dispose() {
    _dateController.dispose();
    _timecontroller.dispose();
    _reasoncontroller.dispose();
    super.dispose();
  }

  // Sending email to the counselee informing them on their approval status
  String? encodeQueryParameters(Map<String, String>params){
    return params.entries
    .map((MapEntry<String, String>e) =>
    '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeComponent(e.value)}'
    ).join('&');
  }
  
  @override
  Widget build(BuildContext context){
    final email = Uri(
      scheme: 'mailto',
      path: '${widget.counselor_email}',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Request to reschedule the counseling session',
        'body': 'Hello,\n\n I wish to reschedule the counseling session I booked on ${widget.created_at}, to:\n\n date: ${_dateController.text} \n time: ${_timecontroller.text}. \n This is because,\n $reason.\n\n Kind regards',
      }),
    );
    Future<void>_sendEmail() async{
      try{
        if(await canLaunchUrl(email)){
          await launchUrl(email);
        }
      }catch(e){
        showDialog(context: context, builder: (context){
          return const AlertDialog(
            content: Text('Error while launching email sender app'),
          );
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: const Text('Error while launching email sender app')),
        // );
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MainPage();
      },));
    }
    // Function to reschedule session
    
    Future reschedule(DateTime dateRescheduledTo, String reason) async{
      try{
        // Loading
      showDialog(
        context: context, 
        builder: (context){
          return const Center(child: CircularProgressIndicator());
        }
      );
      // Pop out the loading widget
      Navigator.of(context).pop();
      //Creating user information with email and registration

      await FirebaseFirestore.instance.collection('bookings').doc(widget.docID).update({
          // Add the user to the collection
          'date_time_rescheduled': dateRescheduledTo,
          'date_time_booked': date_time_rescheduled_to,
          'reason_for_reschedule': reason,
          'rescheduled_at': DateTime.now(),
          'approval': 'Rescheduled',
        });
      
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return MainPage();
      }));

      await showDialog(context: context, builder: (context){
        return const AlertDialog(
          content: Text('Session Rescheduled Successful\n Kindly Confirm email before sending and Wait for Approval.'),
        );
      });
      _sendEmail();
      }on FirebaseAuthException catch(e){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
          // Pop out the loading widget
          Navigator.of(context).pop();
        } 
      return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return MainPage();
      }));
    }

    Future rescheduleSession() async {
      try{
        // Loading
        showDialog(
          context: context, 
          builder: (context){
            return const Center(child: CircularProgressIndicator());
          }
        );
        // Pop out the loading widget
        Navigator.of(context).pop();

        reschedule(
          date_time_rescheduled_to,
          _reasoncontroller.text.trim(),
        );
      }catch(e){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text(e.toString()),
          );
        });
      }
    }


    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reschedule Booked session'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Check Counselor Schedule then Choose Date & Time to reschedule',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade500,
                      ),
                    ),
                  ),
                ),
                // const Text('Choose date and time you wish to reschedule to'),
          
                const SizedBox(height: 10,),
          
                // Button to ask the Counselee check Counselor Schedule
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        highlightColor: Colors.deepPurple[600],
                        color: Colors.deepPurple,
                        padding: const EdgeInsets.all(10.0),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CalendarPage()));
                        },
                        child: const Text(
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
          
                // Date they wish to reschedule to
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        onTap: () => displayDatePicker(context),
                        readOnly: true,
                        controller: _dateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: DateHint,
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
                
                const SizedBox(height: 10.0,),
          
                // Time they wish to reschedule to
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        onTap: () => displayTimePicker(context),
                        readOnly: true,
                        controller: _timecontroller,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: TimeHint,
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
          
                const SizedBox(height: 10.0,),
          
                // Reason Why you are rescheduling the session
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _reasoncontroller,
                        keyboardType: TextInputType.text,
                        minLines: 2,
                        maxLines: null,
                        onEditingComplete: () => setState(() {
                          reason = _reasoncontroller.text;
                        }),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter the reason why you are \nrescheduling the Counseling \nsession you had booked earlier.',
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'This field cannot be empty';
                          }return null;
                        },
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 20,),

                // Button to reschedule bookings
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(    
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            reason = _reasoncontroller.text;
                          });
                          rescheduleSession();
                        }
                      },             
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: const Center(
                          child: Text(
                            'Reschedule Session',
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
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}