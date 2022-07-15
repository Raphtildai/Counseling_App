// ignore_for_file: prefer_const_constructors

import 'package:careapp/screens/home/Counselee/counselee.dart';
import 'package:careapp/screens/home/Counselee/counselee_drawer.dart';
import 'package:flutter/material.dart';

class CounseleeHome extends StatelessWidget {
const CounseleeHome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Counselee\'s Dashboard'),
        centerTitle: true,
      ),
      drawer: CounseleeDrawer(),
      body: CounseleePage(),
    );
  }
}