import 'dart:typed_data';

import 'package:careapp/functionalities/reports/report_details.dart';
import 'package:careapp/functionalities/reports/report_details.dart';
import 'package:careapp/functionalities/reports/report_pdf_export.dart';
import 'package:careapp/functionalities/reports/reports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ReportsList extends StatelessWidget {
ReportsList({ Key? key }) : super(key: key);
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
        title: Text('List of Counselee Based on Gender'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                              return Reports(
                                regnumber: '${data['regnumber']}',
                                date_booked: '${data['date_booked']}',
                                time_booked: '${data['time_booked']}',
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
    );
  }
}