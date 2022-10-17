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
  @override
  Widget build(BuildContext context) {
    return const Reports();
  }
}
