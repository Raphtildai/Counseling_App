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
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ReportsList extends StatefulWidget {
  ReportsList({Key? key}) : super(key: key);

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
  }) =>
      Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          text,
          textAlign: align,
        ),
      );

  final List<String> docIDs = [];
  final List userData = [];

  Future getReports() async {
    var doc = await FirebaseFirestore.instance
        .collection('bookings')
        .orderBy('approval')
        .get()
        .then((snapshot) {
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
    List docIDs = [];
  }

  // Function to fetch the list of bookings
  fetchBookingList() async {
    dynamic resultant = await DatabaseManager().getBookingsData();

    if (resultant == null) {
      print('No bookings found');
    } else {
      setState(() {
        booking = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  // The first Row contains the table head
                  TableRow(children: [
                    Padding(
                        padding: EdgeInsets.all(1),
                        child: Text(
                          'Counselee Email',
                          style: header,
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: EdgeInsets.all(1),
                        child: Text(
                          'Status',
                          style: header,
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Date Booked',
                          style: header,
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Time Booked',
                          style: header,
                          textAlign: TextAlign.center,
                        )),
                  ]),
                ],
              ),
              FutureBuilder(
                future: getReports(),
                builder: (context, snapshot) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        primary: false,
                        itemCount: docIDs.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: ((context, index) {
                          CollectionReference counselee =
                              FirebaseFirestore.instance.collection('bookings');
                          return FutureBuilder<DocumentSnapshot>(
                            future: counselee.doc(docIDs[index]).get(),
                            builder: ((context, snapshot) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              DateTime date_booked = data
                                              ['approval'] ==
                                          'Approved' ||
                                      data['approval'] == 'Pending'
                                  ? data['date_time_booked'].toDate()
                                  : data['date_time_rescheduled']
                                      .toDate();
                              var date_time_booked =
                                  DateFormat('dd/MM/yyyy').format(date_booked);
                              var time_booked =
                                  DateFormat('HH:mm').format(date_booked);
                              DateTime date_rescheduled = data
                                              ['approval'] ==
                                          'Approved' ||
                                      data['approval'] == 'Pending'
                                  ? data['date_time_booked'].toDate()
                                  : data['date_time_rescheduled']
                                      .toDate();
                              var date_rescheduled_to = DateFormat('dd/MM/yyyy')
                                  .format(date_rescheduled);
                              var time_rescheduled_to =
                                  DateFormat('HH:mm').format(date_rescheduled);
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  // Testing(docID: docIDs[index],)));
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ReportPdfExport(
                                      // regnumber: '${data['regnumber']}',
                                      // date_booked: data['date_booked'],
                                      time_booked: '$time_booked',
                                      doc: '${docIDs[index]}',
                                      counselorID:
                                          '${data['counselorID']}',
                                      date_rescheduled: '$date_rescheduled_to',
                                      time_rescheduled: '$time_rescheduled_to',
                                      counselee_email:
                                          '${data['counselee_email']}',
                                      date_booked: '${date_time_booked}',
                                      status: '${data['approval']}',

                                      // approved: data['date_approved'],
                                    );
                                  }));
                                },
                                child: Table(
                                  border: TableBorder.all(color: Colors.black),
                                  children: [
                                    TableRow(children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          // userData[index]['firstname'],
                                          data['counselee_email'],
                                          style: body,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          data['approval'],
                                          // data['approval'],
                                          style: body,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      data['approval'] == 'Approved'
                                          ? Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                date_time_booked, //data['date_booked']
                                                style: body,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                date_rescheduled_to, //data['date_booked']
                                                style: body,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                      data['status'] == 'Approved'
                                          ? Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                time_booked, //data['date_booked']
                                                style: body,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                time_rescheduled_to, //data['date_booked']
                                                style: body,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                    ]),
                                  ],
                                ),
                              );
                              // // We get the collection of the appointments
                              // CollectionReference sessions = FirebaseFirestore.instance.collection('bookings');
                              // return FutureBuilder <DocumentSnapshot>(
                              //   future: sessions.doc(data).get(),
                              //   builder: (context, snapshot) {
                              //     if(snapshot.connectionState == ConnectionState.done){
                              //       Map <String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;

                              //     }
                              //     return Center(child: CircularProgressIndicator(),);
                              //   },
                              // );
                            }),
                          );
                        }),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
