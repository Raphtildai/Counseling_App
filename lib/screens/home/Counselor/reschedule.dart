import 'package:flutter/material.dart';

class Reschedule extends StatelessWidget {
  final counselorID;
const Reschedule({ Key? key, this.counselorID }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Resechule sessions'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}