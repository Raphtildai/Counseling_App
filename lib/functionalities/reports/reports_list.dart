import 'dart:typed_data';

import 'package:careapp/functionalities/reports/report_details.dart';
import 'package:careapp/functionalities/reports/report_details.dart';
import 'package:careapp/functionalities/reports/report_pdf_export.dart';
import 'package:careapp/functionalities/reports/reports.dart';
import 'package:careapp/functionalities/reports/testing.dart';
import 'package:careapp/functionalities/session_booking.dart';
import 'package:careapp/models/database_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ReportsList extends StatefulWidget {
ReportsList({ Key? key }) : super(key: key);

  @override
  State<ReportsList> createState() => _ReportsListState();
}

class _ReportsListState extends State<ReportsList> {
  TextStyle header = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  TextStyle body = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

// creating a table
Widget PaddedText(
  final String text, {
    final TextAlign align = TextAlign.left,
  }
) => Padding(padding: EdgeInsets.all(10),
child: Text(
  text,
  textAlign: align,
),);

final List<String> docIDs = [];
final List userData = [];

Future getReports() async {
  var doc =await FirebaseFirestore.instance.collection('bookings')
  .where('approval', isEqualTo: 'Approved')
  .get().then((snapshot){
    snapshot.docs.forEach((doc) {
      docIDs.add(doc.reference.id);
    });
  });
}

// List of bookings in the database
List booking = [];
List user = [];  

@override
  void initState() {
    super.initState();
    fetchBookingList();
  }

  // Function to fetch the list of bookings
  fetchBookingList() async{
    dynamic resultant = await DatabaseManager().getBookingsData();

    if(resultant == null){
      print('No bookings found');
    }else{
      setState(() {
        booking = resultant;
      });
    }
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Column(
            children: [
              const Text(
                'Report on Counselee Session Booking', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20,),
              Table(
                border: TableBorder.all(
                  color: Colors.black),
                children: [
                    // The first Row contains the table head
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Text(
                          'Name',
                          style: header,
                          textAlign: TextAlign.center,
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Text(
                          'Registration Number',
                          style: header,
                          textAlign: TextAlign.center,
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Date Booked',
                          style: header,
                          textAlign: TextAlign.center,
                        )
                      ),
                    ]
                  ),
                ],
              ),
              FutureBuilder(
                future: getReports(),
                builder: (context, snapshot) {
                  return Container(
                    height: 300,
                    child: Expanded(
                      child: ListView.builder(
                        primary: false,
                        itemCount: booking.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: ((context, index) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                // Testing(docID: docIDs[index],)));
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return ReportPdfExport(
                                    // regnumber: '${data['regnumber']}', 
                                    // date_booked: data['date_booked'], 
                                    time_booked: '${booking[index]['time_booked']}', 
                                    doc: '${booking[index]}', 
                                    counselorID: '${booking[index]['counselorID']}',
                                    // approved: data['date_approved'],
                                  );
                        
                                }));
                              },
                              child: Column(
                                children: [
                                  Table(
                                    border: TableBorder.all(
                                      color: Colors.black),
                                    children: [
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Expanded(
                                              child: Text(
                                                // userData[index]['firstname'],
                                                'Raph',
                                                style: body,
                                                textAlign: TextAlign.center,
                                              )
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Expanded(
                                              child: Text(
                                                booking[index]['approval'],
                                                // data['approval'],
                                                style: body,
                                                textAlign: TextAlign.center,
                                              )
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Expanded(
                                              child: Text(
                                                booking[index]['time_booked'], //data['date_booked']
                                                style: body,
                                                textAlign: TextAlign.center,
                                              )
                                            ),
                                          ),
                                        ]
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                          // // We get the collection of the appointments
                          // CollectionReference sessions = FirebaseFirestore.instance.collection('bookings');
                          // return FutureBuilder <DocumentSnapshot>(
                          //   future: sessions.doc(booking[index]).get(),
                          //   builder: (context, snapshot) {
                          //     if(snapshot.connectionState == ConnectionState.done){
                          //       Map <String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
                                
                          //     }
                          //     return Center(child: CircularProgressIndicator(),);
                          //   },
                          // );
                          
                        }),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}