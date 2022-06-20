import 'package:flutter/material.dart';

class Account_page extends StatefulWidget {
  const Account_page({Key? key}) : super(key: key);

  @override
  State<Account_page> createState() => _Account_pageState();
}

class _Account_pageState extends State<Account_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
    );
  }
}