import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportDetails extends StatelessWidget {
  final doc;  
  final String regnumber;
  final String date_booked;
  final String time_booked;
  final String counselee_email;
  final String created_at;
  final String counseleeID;
const ReportDetails({ 
  Key? key, 
  required this.doc, 
  required this.regnumber, 
  required this.date_booked, 
  required this.time_booked, 
  required this.counselee_email, 
  required this.created_at, 
  required this.counseleeID 
}) : super(key: key);

// Advanced Pdf
Future<Uint8List> _generatePdf(PdfPageFormat format, String title)async{
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = await PdfGoogleFonts.nunitoExtraLight();
  //Inserting logo into our pdf
  final image = await imageFromAssetBundle('assets/logo1.png');

  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context){
        return pw.Padding(
          padding: pw.EdgeInsets.symmetric(horizontal: 25),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              // Header of the document
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  // Logo of the Company
                  pw.Image(
                    image,
                    height: 100,
                    width: 100,
                  ),

                  // Title of the report
                  pw.Text(title, style: pw.TextStyle(font: font, fontSize: 20)),

                  // pw.SizedBox(height: 5),
                ]
              ),

              pw.Divider(
                color: PdfColor.fromInt(0),
                height: 10,
                thickness: 1,
              ),


              // Content of the Report
              // Regnumber
              pw.Row(
                children: [
                  pw.Text('Registration number'),
                  pw.SizedBox(width: 10),
                  pw.Text(regnumber),
                ],
              ),

              // date booked

              pw.Row(
                children: [
                  pw.Text('Date Booked'),
                  pw.SizedBox(width: 10),
                  pw.Text(date_booked),
                ],
              ),

              // Footer or the Report
            ]
          ),
        );
      }
    ),
  );
  return pdf.save();
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
      ),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "mydoc.pdf",
      )
    );;
  }
}






// import 'package:careapp/functionalities/reports/pdfexport.dart';
// import 'package:careapp/functionalities/reports/pdfpreviewpage.dart';
// import 'package:careapp/functionalities/reports/report.dart';
// import 'package:careapp/functionalities/reports/report.dart';
// import 'package:flutter/material.dart';

// class Details extends StatelessWidget {
//   final rep;
//   const Details({
//     Key? key,
//     required this.rep
//   }):super(key: key);
  

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => Pdfpreviewpage(rep: rep)),
//           );
//         },
//         child: Icon(Icons.picture_as_pdf),
//       ),
//       appBar: AppBar(
//         title: Text('Details page'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: [
//           Padding(padding: const EdgeInsets.all(15.0),
//           child: Card(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(child: Text(
//                   'Counselee',
//                   style: Theme.of(context).textTheme.headline5,
//                 ),),
//                 Expanded(child: Text(
//                   rep.counselee,
//                   style: Theme.of(context).textTheme.headline4,
//                   textAlign: TextAlign.center,
//                 )),
//               ],
//             ),
//           ),
//         ),

//         Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Card(
//             child: Column(
//               children: [
//                 Text(
//                   'Details Items',
//                   style: Theme.of(context).textTheme.headline6,
//                 ),
//                 ...rep.items.map((e) => ListTile(
//                   title: Text(e.date_booked),
//                   subtitle: Text(e.date_rescheduled),
//                 )),

//               ],
//             ),
//           ),
        
//         )
//       ],

//       ),
//     );
//   }
// }