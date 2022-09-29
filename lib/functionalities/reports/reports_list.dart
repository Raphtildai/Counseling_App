import 'dart:typed_data';

import 'package:careapp/functionalities/reports/report_details.dart';
import 'package:careapp/functionalities/reports/report_details.dart';
import 'package:careapp/functionalities/reports/report_pdf_export.dart';
import 'package:careapp/functionalities/reports/reports.dart';
import 'package:careapp/functionalities/session_booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ReportsList extends StatelessWidget {
ReportsList({ Key? key }) : super(key: key);

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

Future getReports() async {
  var doc =await FirebaseFirestore.instance.collection('bookings').where('approval', isEqualTo: 'Approved').get().then((snapshot){
    snapshot.docs.forEach((doc) {
      docIDs.add(doc.reference.id);
    });
  });
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
                        itemCount: docIDs.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: ((context, index) {
                          // We get the collection of the appointments
                          CollectionReference sessions = FirebaseFirestore.instance.collection('bookings');
                          return FutureBuilder <DocumentSnapshot>(
                            future: sessions.doc(docIDs[index]).get(),
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.done){
                                Map <String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: (() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return ReportPdfExport(regnumber: '${data['regnumber']}', date_booked: data['date_booked'], time_booked: '${data['time_booked']}', doc: '${docIDs[index]}', );
                              
                                      }));
                                    }),
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
                                                      data['regnumber'],
                                                      style: body,
                                                      textAlign: TextAlign.center,
                                                    )
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Expanded(
                                                    child: Text(
                                                      data['date_booked'],
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
                              }
                              return Center(child: CircularProgressIndicator(),);
                            },
                          );
                          
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