import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/screens/home/Counselor/approve_session.dart';
import 'package:careapp/screens/home/home.dart';
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
  final String regnumber;
  final String date_booked;
  final String time_booked;
  final String counselee_email;
  final String created_at;
  final String counseleeID;
  final String docID;

const Reschedule({ 
    Key? key,
    required this.regnumber,
    required this.date_booked,
    required this.time_booked,
    required this.counselee_email,
    required this.created_at, 
    required this.counseleeID,
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

String DateHint = 'Date Format YYYY-MM-DD';
 String TimeHint = 'Time Format HH:MM';

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
      _dateController.text = date.toLocal().toString().split(" ")[0];
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

  // Function to reschedule session
  Future rescheduleSession() async {
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

      reschedule(
        _dateController.text.trim(),
        _timecontroller.text.trim(),
        _reasoncontroller.text.trim(),
      );
    }catch(e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.toString()),
        );
      });
    }
  }
  Future reschedule(String date_rescheduled, String time_rescheduled, String reason) async{
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

    var reschedule = await FirebaseFirestore.instance.collection('bookings').doc(this.widget.docID).update({
        // Add the user to the collection
        'date_rescheduled': date_rescheduled,
        'time_rescheduled': time_rescheduled,
        'reason_for_reschedule': reason,
        'rescheduled_at': DateFormat.yMMMEd().format(DateTime.now()),
        'approval': 'Rescheduled',
      });
    
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return Home();
    }));

    showDialog(context: context, builder: (context){
      return const AlertDialog(
        content: Text('Session Rescheduled Successful\n Wait for Approval.'),
      );
    });
    }on FirebaseAuthException catch(e){
      print(e);
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        });
        // Pop out the loading widget
        Navigator.of(context).pop();
      } 
    return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return Home();
    }));
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
      path: widget.counselee_email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Your Counseling Session was Rescheduled Successfully',
        'body': 'Hello,\n Your Counseling Session which you booked on ${widget.created_at}, for date: ${widget.date_booked} time: ${widget.time_booked}, has been approved.\n You\'ll be contacted by one of our counselors soon.\n\n Kind regards',
      }),
    );
    Future<void>_sendEmail() async{
      try{
        if(await canLaunchUrl(email)){
          await launchUrl(email);
        }
      }catch(e){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text('Error while launching email sender app'),
          );
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: const Text('Error while launching email sender app')),
        // );
      }
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return Home();
      // },));
    }
    // Function to approve session
    Future approveSession(String docID) async {
      try{
        final approval = await FirebaseFirestore.instance.collection('bookings')
        .doc('$docID').update({
          'approval': "Approved",
          'counselorID': FirebaseAuth.instance.currentUser?.uid,
          'counseleeID' : FirebaseAuth.instance.currentUser!.uid,
          'time_approved': DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now()),
        });
        // const approveSession(docid);
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: const Text('The session has been approved successfully.\n\n Open your email application to send the approval status below!'),
          );
        });
        _sendEmail();
      }
      catch(e){
        // Alerting the user on errors which might arise on the app
        showDialog(context: context, builder: (context){
          return AlertDialog(
            content: Text(e.toString()),
          );
        });
      }
      return MainPage();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reschedule Booked session'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Choose date and time you wish to reschedule to'),

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
                    child: TextField(
                      controller: _dateController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: DateHint,
                      ),
                    ),
                  ),
                ),
              ),
          
                // SizedBox(height: 5.0,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: MaterialButton(
                    highlightColor: Colors.deepPurple[600],
                    color: Colors.deepPurple[400],
                    padding: EdgeInsets.all(10.0),
                    onPressed: () => displayDatePicker(context),
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
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
                    child: TextField(
                      controller: _timecontroller,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: TimeHint,
                      ),
                    ),
                  ),
                ),
              ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: MaterialButton(
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
                ),

                const SizedBox(height: 10.0,),

              // Reason Why you are rescheduling the session
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _reasoncontroller,
                      keyboardType: TextInputType.text,
                      minLines: 2,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter the reason why you are \nrescheduling the Counseling \nsession you had booked earlier.',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              // Button to submit bookings
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(    
                    onTap: (){
                      rescheduleSession();
                    },             
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
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
    );
  }
}