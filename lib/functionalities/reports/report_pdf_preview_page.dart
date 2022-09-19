
























































// import 'dart:typed_data';

// import 'package:careapp/functionalities/reports/report.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:printing/printing.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:careapp/functionalities/reports/pdfexport.dart';

// class Pdfpreviewpage extends StatelessWidget {
//   final rep;
// const Pdfpreviewpage({ Key? key, required this.rep }) : super(key: key);

  
//   makePdf(report rep) {
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

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF preview'),
//         centerTitle: true,
//       ),
//       body: PdfPreview(build: (context) => makePdf(rep)),
//     );
//   }
// }
