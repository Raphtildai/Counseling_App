import 'package:careapp/functionalities/reports/report_pdf_export.dart';
import 'package:careapp/models/database_manager.dart';
import 'package:careapp/utilities/error_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
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
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          textAlign: align,
        ),
      );

  final List<String> docIDs = [];

  Future getReports() async {
    await FirebaseFirestore.instance
        .collection('bookings')
        .orderBy('approval')
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        docIDs.add(doc.reference.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        
        },
        child: const Icon(Icons.picture_as_pdf),
      ),
      appBar: AppBar(
        title: const Text('Booking Reports'),
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
                        padding: const EdgeInsets.all(1),
                        child: Text(
                          'Counselee Email',
                          style: header,
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(1),
                        child: Text(
                          'Status',
                          style: header,
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Date Booked',
                          style: header,
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(5),
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
                  if (docIDs.isEmpty) {
                    return ErrorPage('No Bookings Found');
                  } else {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          primary: false,
                          itemCount: docIDs.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: ((context, index) {
                            CollectionReference counselee = FirebaseFirestore
                                .instance
                                .collection('bookings');
                            return FutureBuilder<DocumentSnapshot>(
                              future: counselee.doc(docIDs[index]).get(),
                              builder: ((context, snapshot) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                if (snapshot.hasData) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    DateTime dateBooked =
                                        data['approval'] == 'Approved' ||
                                                data['approval'] == 'Pending'
                                            ? data['date_time_booked'].toDate()
                                            : data['date_time_rescheduled']
                                                .toDate();
                                    var dateTimeBooked =
                                        DateFormat('dd/MM/yyyy')
                                            .format(dateBooked);
                                    var timeBooked =
                                        DateFormat('HH:mm').format(dateBooked);
                                    DateTime dateRescheduled =
                                        data['approval'] == 'Approved' ||
                                                data['approval'] == 'Pending'
                                            ? data['date_time_booked'].toDate()
                                            : data['date_time_rescheduled']
                                                .toDate();
                                    var dateRescheduledTo =
                                        DateFormat('dd/MM/yyyy')
                                            .format(dateRescheduled);
                                    var timeRescheduledTo =
                                        DateFormat('HH:mm')
                                            .format(dateRescheduled);
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        // Testing(docID: docIDs[index],)));
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ReportPdfExport(
                                            time_booked: timeBooked,
                                            doc: docIDs[index],
                                            counselorID:
                                                '${data['counselorID']}',
                                            date_rescheduled:
                                                dateRescheduledTo,
                                            time_rescheduled:
                                                timeRescheduledTo,
                                            counselee_email:
                                                '${data['counselee_email']}',
                                            date_booked: dateTimeBooked,
                                            status: '${data['approval']}',

                                            // approved: data['date_approved'],
                                          );
                                        }));
                                      },
                                      child: Table(
                                        border: TableBorder.all(
                                            color: Colors.black),
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                // userData[index]['firstname'],
                                                data['counselee_email'],
                                                style: body,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                data['approval'],
                                                // data['approval'],
                                                style: body,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            data['approval'] == 'Approved'
                                                ? Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text(
                                                      dateTimeBooked, //data['date_booked']
                                                      style: body,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text(
                                                      dateRescheduledTo, //data['date_booked']
                                                      style: body,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                            data['status'] == 'Approved'
                                                ? Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text(
                                                      timeBooked, //data['date_booked']
                                                      style: body,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text(
                                                      timeRescheduledTo, //data['date_booked']
                                                      style: body,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                          ]),
                                        ],
                                      ),
                                    );
                                  }
                                } else if (snapshot.hasError) {
                                  return ErrorPage('${snapshot.error}');
                                } else {
                                  return ErrorPage('No Data found');
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
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
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:careapp/functionalities/reports/report_pdf_export.dart';
// import 'package:careapp/screens/home/Counselor/approve_session.dart';
// import 'package:flutter/material.dart';

// class Reports extends StatelessWidget {
//   final String doc;
//   final String regnumber;
//   final DateTime date_booked;
//   final String time_booked;

//   TextStyle header = const TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.bold,
//   );
// Reports({ 
//   Key? key, 
//   required this.doc,
//   required this.regnumber, 
//   required this.date_booked, 
//   required this.time_booked, 
//   required String counseleeID,
//   required String counselorID,
//   required DateTime approved,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context){
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25),
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context){
//               return ReportPdfExport(
//                 // regnumber: regnumber, 
//                 // date_booked: date_booked, 
//                 time_booked: time_booked, 
//                 doc: doc, 
//                 counselorID: '${counseleeID}', 
//                 time_rescheduled: '', 
//                 date_rescheduled: '', 
//                 counselee_email: '', 
//                 date_booked: '',
//                 status: '',
//               );
    
//             }));
//           },
//           child: Column(
//             children: [
//               SizedBox(height: 10,),
//               Table(
//                 border: TableBorder.all(
//                   color: Colors.black),
//                   children: [
//                   //   // The first Row contains the table head
//                   // TableRow(
//                   //   children: [
//                   //     Padding(
//                   //       padding: EdgeInsets.all(1),
//                   //       child: Text(
//                   //         'Name',
//                   //         style: header,
//                   //         textAlign: TextAlign.center,
//                   //       )
//                   //     ),
//                   //     Padding(
//                   //       padding: EdgeInsets.all(1),
//                   //       child: Text(
//                   //         'Registration Number',
//                   //         style: header,
//                   //         textAlign: TextAlign.center,
//                   //       )
//                   //     ),
//                   //     Padding(
//                   //       padding: EdgeInsets.all(5),
//                   //       child: Text(
//                   //         'Gender',
//                   //         style: header,
//                   //         textAlign: TextAlign.center,
//                   //       )
//                   //     ),
                      
//                   //   ]
//                   // ),
//                   // Below is the list
//                   TableRow(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(5),
//                         child: Expanded(
//                           child: Text(
//                             'Raph',
//                             style: header,
//                             textAlign: TextAlign.center,
//                           )
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(5),
//                         child: Expanded(
//                           child: Text(
//                             regnumber,
//                             style: header,
//                             textAlign: TextAlign.center,
//                           )
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(5),
//                         child: Expanded(
//                           child: Text(
//                             date_booked.toString(),
//                             style: header,
//                             textAlign: TextAlign.center,
//                           )
//                         ),
//                       ),
//                     ]
//                   ),
//                 ]
                  
//               ),
              
//               // Row(
//               //   children: [
//               //     Text('Reg No.', style: TextStyle(fontWeight: FontWeight.bold),),
//               //     SizedBox(width: 15,),
//               //     Text('Date', style: TextStyle(fontWeight: FontWeight.bold),),
//               //     SizedBox(width: 10,),
//               //     Text('Time', style: TextStyle(fontWeight: FontWeight.bold),),
//               //     SizedBox(width: 10),
//               //   ],
//               // ),

//               // SizedBox(height: 10,),

//               // Row(
//               //   children: [
//               //     Text(regnumber),
//               //     SizedBox(width: 10,),
//               //     Text(date_booked),
//               //     SizedBox(width: 10,),
//               //     Text(time_booked),
//               //     SizedBox(width: 10,),
//               //   ],
//               // ),
//               // SizedBox(height: 10,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
























// // import 'package:careapp/functionalities/reports/details.dart';
// // import 'package:careapp/functionalities/reports/report.dart';
// // import 'package:flutter/material.dart';

// // class Reports extends StatelessWidget {

// // final counselee = [
// //   report(
// //     'Raphael Tildai', 
// //     'CT201/0005/18', 
// //     'male',
// //     [
// //       BookingHistory(
// //         '2022/05/19', 
// //         '2022/05/20',
// //       ),
// //     ],
// //   ),
// //   report(
// //     'Joyline Akinyi', 
// //     'CT202/1010/19', 
// //     'female',
// //     [
// //       BookingHistory(
// //         '2022/05/19', 
// //         '2022/05/20',
// //       ),
// //     ],
// //   ),

// // ];

// //   @override
// //   Widget build(BuildContext context){
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Reports on Session booking'),
// //         centerTitle: true,
// //       ),
// //       body: ListView(
// //         children: [
// //           ...counselee.map((e) => ListTile(
// //             title: Text(e.counselee),
// //             subtitle: Text(e.regnumber),
// //             trailing: Text(e.gender),
// //             onTap: () {
// //               Navigator.of(context).push(
// //                 MaterialPageRoute(builder: (builder)=>Details(rep: e)),
// //               );
// //             },
// //           ))
// //         ],
// //       ),
// //     );
// //   }
// // }