import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final child;
  const NeuBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(child: child,),
      decoration: BoxDecoration(
        color: Colors.deepPurple[100],
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          // Darker region on the right
          BoxShadow(
            color: Colors.deepPurple.shade200,
            blurRadius: 10,
            offset: Offset(5, 5),
          ),

          // Lighter region
          BoxShadow(
            color: Colors.white,
            blurRadius: 10,
            offset: Offset(-5, -5),
          ),
        ],
      ),
    );
  }
}