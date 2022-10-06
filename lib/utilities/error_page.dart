import 'package:flutter/material.dart';

Widget ErrorPage(String error){
  
    var error2 = error;
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurple[200],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(error2, style: const TextStyle(fontSize: 16.0),),
        ),
      ),
    ));
 
  
}