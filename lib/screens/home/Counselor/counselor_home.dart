import 'package:careapp/screens/home/Counselor/counselors_page.dart';
import 'package:careapp/screens/home/Counselor/counselor_drawer.dart';
import 'package:flutter/material.dart';

class CounselorHome extends StatefulWidget {
  const CounselorHome({ Key? key }) : super(key: key);

  @override
  _CounselorHomeState createState() => _CounselorHomeState();
}

class _CounselorHomeState extends State<CounselorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counselor\'s Dashboard'),
        centerTitle: true,
      ),  
      drawer: CounselorDrawer(),
      body: Counselors_page(),    
    );
  }
}