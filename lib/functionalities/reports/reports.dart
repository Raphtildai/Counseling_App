import 'package:careapp/functionalities/reports/report_pdf_export.dart';
import 'package:careapp/screens/home/Counselor/approve_session.dart';
import 'package:flutter/material.dart';

class Reports extends StatelessWidget {
  final String doc;
  final String regnumber;
  final DateTime date_booked;
  final String time_booked;

  TextStyle header = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
Reports({ 
  Key? key, 
  required this.doc,
  required this.regnumber, 
  required this.date_booked, 
  required this.time_booked, 
  required String counseleeID,
  required String counselorID,
  required DateTime approved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ReportPdfExport(
                // regnumber: regnumber, 
                // date_booked: date_booked, 
                time_booked: time_booked, 
                doc: doc, 
                counselorID: '${counseleeID}',
              );
    
            }));
          },
          child: Column(
            children: [
              SizedBox(height: 10,),
              Table(
                border: TableBorder.all(
                  color: Colors.black),
                  children: [
                  //   // The first Row contains the table head
                  // TableRow(
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.all(1),
                  //       child: Text(
                  //         'Name',
                  //         style: header,
                  //         textAlign: TextAlign.center,
                  //       )
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.all(1),
                  //       child: Text(
                  //         'Registration Number',
                  //         style: header,
                  //         textAlign: TextAlign.center,
                  //       )
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.all(5),
                  //       child: Text(
                  //         'Gender',
                  //         style: header,
                  //         textAlign: TextAlign.center,
                  //       )
                  //     ),
                      
                  //   ]
                  // ),
                  // Below is the list
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Expanded(
                          child: Text(
                            'Raph',
                            style: header,
                            textAlign: TextAlign.center,
                          )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Expanded(
                          child: Text(
                            regnumber,
                            style: header,
                            textAlign: TextAlign.center,
                          )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Expanded(
                          child: Text(
                            date_booked.toString(),
                            style: header,
                            textAlign: TextAlign.center,
                          )
                        ),
                      ),
                    ]
                  ),
                ]
                  
              ),
              
              // Row(
              //   children: [
              //     Text('Reg No.', style: TextStyle(fontWeight: FontWeight.bold),),
              //     SizedBox(width: 15,),
              //     Text('Date', style: TextStyle(fontWeight: FontWeight.bold),),
              //     SizedBox(width: 10,),
              //     Text('Time', style: TextStyle(fontWeight: FontWeight.bold),),
              //     SizedBox(width: 10),
              //   ],
              // ),

              // SizedBox(height: 10,),

              // Row(
              //   children: [
              //     Text(regnumber),
              //     SizedBox(width: 10,),
              //     Text(date_booked),
              //     SizedBox(width: 10,),
              //     Text(time_booked),
              //     SizedBox(width: 10,),
              //   ],
              // ),
              // SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
























// import 'package:careapp/functionalities/reports/details.dart';
// import 'package:careapp/functionalities/reports/report.dart';
// import 'package:flutter/material.dart';

// class Reports extends StatelessWidget {

// final counselee = [
//   report(
//     'Raphael Tildai', 
//     'CT201/0005/18', 
//     'male',
//     [
//       BookingHistory(
//         '2022/05/19', 
//         '2022/05/20',
//       ),
//     ],
//   ),
//   report(
//     'Joyline Akinyi', 
//     'CT202/1010/19', 
//     'female',
//     [
//       BookingHistory(
//         '2022/05/19', 
//         '2022/05/20',
//       ),
//     ],
//   ),

// ];

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reports on Session booking'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: [
//           ...counselee.map((e) => ListTile(
//             title: Text(e.counselee),
//             subtitle: Text(e.regnumber),
//             trailing: Text(e.gender),
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(builder: (builder)=>Details(rep: e)),
//               );
//             },
//           ))
//         ],
//       ),
//     );
//   }
// }