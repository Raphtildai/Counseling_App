import 'package:careapp/screens/home/Counselee/counselee_profile.dart';
import 'package:careapp/screens/home/Counselor/approve_session.dart';
import 'package:careapp/screens/home/Counselor/counselor_home.dart';
import 'package:careapp/screens/home/Counselor/reschedule.dart';
import 'package:careapp/screens/home/Counselor/reschedule_session.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BookedSession extends StatefulWidget {
  static const titleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
static const textStyle = TextStyle(
  fontSize: 14,
);
  // Parameters to be passed to the booked session card
  final String regnumber;
  final String date_booked;
  final String time_booked;
  final String counseleeID;
  final String counselee_email;
  final String created_at;
  final String docID;
const BookedSession({ 
  Key? key, 
  required this.regnumber, 
  required this.date_booked, 
  required this.time_booked, 
  required this.counseleeID ,
  required this.counselee_email,
  required this.created_at,
  required this.docID
  }) : super(key: key);

  @override
  State<BookedSession> createState() => _BookedSessionState();
}
// Sending email to the counselee informing them on their approval status
String? encodeQueryParameters(Map<String, String>params){
  return params.entries
  .map((MapEntry<String, String>e) =>
  '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeComponent(e.value)}'
  ).join('&');
}
class _BookedSessionState extends State<BookedSession> {
 
  @override
  Widget build(BuildContext context){
    final String uid = widget.counseleeID;
    final String counselee_email = widget.counselee_email;
    final String created_at = widget.created_at;
    final String date_booked = widget.date_booked;
    final String time_booked = widget.time_booked;
    final String documentID = widget.docID;
    // Retrieving the date and formatting it
    // var dateCreated = '${data['created_at']}';
    // String date = DateFormat.yMMMEd().format(data['created_at']);
    final email = Uri(
      scheme: 'mailto',
      path: counselee_email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Your Counseling Session was Approved',
        'body': 'Hello,\n Your Counseling Session which you booked on $created_at, for date: $date_booked time: $time_booked, has been approved.\n You\'ll be contacted by one of our counselors soon.\n\n Kind regards',
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Home();
      },));
    }
    // Function to approve session
    Future approveSession(String docID) async {
      try{
        final approval = await FirebaseFirestore.instance.collection('bookings')
        .doc('$docID').update({
          'approval': "Approved",
          'counseleeID' : FirebaseAuth.instance.currentUser!.uid,
          'time_approved': DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.now()),
        });
        const ApproveSession();
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
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color:Colors.deepPurple[200], 
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Counselee's Reg number
                    const Divider(
                      // height: 10,
                      thickness: 1.0,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Reg number:', style: BookedSession.titleStyle,),
                        const SizedBox(width: 10,),
                        Text(widget.regnumber),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    // Date booked
                    
                    const Divider(
                      // height: 10,
                      thickness: 1.0,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Date Booked:', style: BookedSession.titleStyle,),
                        const SizedBox(width: 10,),
                        Text(widget.date_booked),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    // Time booked
                    const Divider(
                      // height: 10,
                      thickness: 1.0,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Time Booked:', style: BookedSession.titleStyle,),
                        const SizedBox(width: 10,),
                        Text(widget.time_booked),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    // // Reading more about the counselee
                    // const Divider(
                    //   // height: 10,
                    //   thickness: 1.0,
                    //   color: Colors.white,
                    // ),
                    // MaterialButton(
                    //   color: Colors.deepPurple,
                    //   textColor: Colors.white,
                    //   onPressed: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //       print(documentID);
                    //       return CounseleeProfile(counseleeID: '',);
                    //     },));
                    //   },
                    //   child: const Text('Counselee Profile'),
                    // ),
                    
                    // const SizedBox(height: 10,),

                    // Approval Buttons
                    const Divider(
                      // height: 10,
                      thickness: 1.0,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: (){
                            print(documentID);
                            approveSession(documentID);
                          },
                          child: const Text('Approve'),
                        ),
                        const SizedBox(width: 20,),
                        MaterialButton(
                          color: Colors.black,
                          textColor: Colors.white,
                          onPressed: (){
                            // Navigator.p
                          },
                          child: const Text('Reschedule'),
                        ),
                      ],
                    ),
                    const Divider(
                      // height: 10,
                      thickness: 1.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}