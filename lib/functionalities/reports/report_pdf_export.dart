import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class ReportPdfExport extends StatefulWidget {
  final String doc;
  // final String regnumber;
  // final DateTime date_booked;
  final String time_booked;
  final String counselorID;
  // final DateTime approved;
ReportPdfExport({ Key? key, 
// required this.regnumber, 
// required this.date_booked, 
required this.time_booked ,
required this.doc,
required this.counselorID,
// required this.approved,
}) : super(key: key);

  @override
  State<ReportPdfExport> createState() => _ReportPdfExportState();
}

var counselee_name = '';
var regNumber = '';
var about_counselee = '';
var school = '';
var course = '';


class _ReportPdfExportState extends State<ReportPdfExport> {
  getUserData() async {
    var coll2 = await FirebaseFirestore.instance.collection('users').doc(widget.doc).get();
    setState(() {
      counselee_name = coll2.data()!['firstname'];
      regNumber = coll2.data()!['regnumber'];
      about_counselee = coll2.data()!['about'];
      school = coll2.data()!['school'];
      course = coll2.data()!['Course'];
    });
  }
  @override
  void initState() {
    getUserData();
    super.initState();
  }

final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

// // Advanced Pdf
Future<Uint8List> _generatePdf(PdfPageFormat format, String title)async{
  final font = await PdfGoogleFonts.nunitoExtraLight();
  //Inserting logo into our pdf
  final image = await imageFromAssetBundle('assets/logo1.png');
pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context){
        return pw.Padding(
          padding: pw.EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.SizedBox(height: 10),
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
              pw.Padding(
                padding: pw.EdgeInsets.all(1),
                child: pw.Text(
                  '${regNumber} Detailed Report',
                  style: pw.Theme.of(context).header3,
                  textAlign: pw.TextAlign.center,
                )
              ),

              // Name

              pw.SizedBox(height: 20),

              pw.Padding(
                padding: pw.EdgeInsets.all(1),
                child: pw.Text(
                  'Counselee Name $counselee_name',
                  style: pw.Theme.of(context).header3,
                  textAlign: pw.TextAlign.center,
                )
              ),

              pw.SizedBox(height: 20),

              pw.Padding(
                padding: pw.EdgeInsets.all(1),
                child: pw.Text(
                  'Counselee unique ID ${widget.doc}',
                  style: pw.Theme.of(context).header3,
                  textAlign: pw.TextAlign.center,
                )
              ),

              pw.SizedBox(height: 20),

              // Counselor who approved your session
              pw.Padding(
                padding: pw.EdgeInsets.all(1),
                child: pw.Text(
                  'Counselor unique ID ${widget.doc}',
                  style: pw.Theme.of(context).header3,
                  textAlign: pw.TextAlign.center,
                )
              ),

              pw.SizedBox(height: 20),



              // Content of the Report
              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColors.black),
                  children: [
                    // The first Row contains the table head
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(1),
                        child: pw.Text(
                          'Name',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        )
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(1),
                        child: pw.Text(
                          'Registration Number',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        )
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          'Date Booked',
                          style: pw.Theme.of(context).header4,
                          textAlign: pw.TextAlign.center,
                        )
                      ),
                      
                    ]
                  ),
                  // Below is the list
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Expanded(
                          child: pw.Text(
                            '$counselee_name',
                            style: pw.Theme.of(context).header4,
                            textAlign: pw.TextAlign.center,
                          )
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Expanded(
                          child: pw.Text(
                            '$regNumber',
                            style: pw.Theme.of(context).header4,
                            textAlign: pw.TextAlign.center,
                          )
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Expanded(
                          child: pw.Text(
                            school,
                            style: pw.Theme.of(context).header4,
                            textAlign: pw.TextAlign.center,
                          )
                        ),
                      ),
                    ]
                  ),
                ]
              ),
              pw.SizedBox(height: 20),

              // Footer or the Report
              pw.Padding(padding: pw.EdgeInsets.only(bottom: 10), child: pw.Column(
                children: [
                  pw.Text('The Best Counseling App'),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('Date of Report Generation'),
                      pw.SizedBox(width: 20),
                      pw.Text('${DateTime.now()}')
                    ]
                  ),
                ]
              )),
              
            ]
          ),
        );
      }
    ),
  );
  return pdf.save();
}

void generatePdf(String cname, String regnumber)async{
  const title = 'Booking Session Reports';
  await Printing.layoutPdf(onLayout: ((format) => _generatePdf(format, title)));
}

void _displayPdf(){
  final doc = pw.Document();
  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Center(
          child: pw.Text('Hello'),
        );
      },
    )
  );
}

//Function to create pdf & print it
void _createPdf() async{
  final doc = pw.Document();

  //Inserting logo into our pdf
  final image = await imageFromAssetBundle('assets/logo1.png');

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Center(
          child: pw.Text('Hello There'),
        );
      },
    ),
  );

  //Printing the document using the ios or Android print services
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());

  //Sharing the document to other applications
  // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

  //tutorial for using path-provider https://www.youtube.com/watch?v=fJtFDrjEvE8
  //save PDF with flutter library "Path Provider"
  // final output = await getTemporaryDirectory();
  // final file = File('${output.path}/example.pdf');
  // await file.writeAsBytes(await doc.save());
}
//Convert a pdf to images, one image per page, get only pages 1 and 2 at 72 dpi
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('${regNumber} Detailed Report'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            generatePdf(counselee_name, regNumber);
            print('Name is $counselee_name');
          },
          child: Text('Generate Report'),
        ),
      ),
    );
  }
}


















// import 'dart:typed_data';

// import 'package:careapp/functionalities/reports/report.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';

// class Pdfexport {
//   final report rep;

//   const Pdfexport({required this.rep});
//   Future<Uint8List?> makePdf(report rep) async{
//   final imageLogo = pw.MemoryImage((await rootBundle.load('assets/logo1.png')).buffer.asUint8List());
//     final pdf = pw.Document();
//     pdf.addPage(
//       pw.Page(
//         build: (context){
//           return pw.Column(
//             children: [
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pw.Text(rep.counselee),
//                   pw.Text(rep.regnumber),
//                 ],
//                 crossAxisAlignment: pw.CrossAxisAlignment.start
//               ),
//               pw.SizedBox(
//                 height: 150,
//                 width: 150,
//                 child: pw.Image(imageLogo),
//               ),
//             ]
//           );
//         }
//       ),
//     );
//     return pdf.save();
//   }
// }