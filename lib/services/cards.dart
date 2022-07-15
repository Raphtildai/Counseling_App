import 'package:flutter/material.dart';
class Cards extends StatelessWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200.0,
        color: Colors.deepPurple[200],
      ),
    );  
  }
}
