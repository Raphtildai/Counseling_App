// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, unused_field, unused_element, unused_local_variable
import 'package:careapp/screens/home/Counselee/counselee_page.dart';
import 'package:careapp/screens/home/Counselor/counselor_list.dart';
import 'package:careapp/screens/home/Counselor/counselors_page.dart';
import 'package:careapp/screens/home/message.dart';
import 'package:careapp/functionalities/settings_page.dart';
import 'package:careapp/utilities/navigation_drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        centerTitle: true,
      ),
      drawer: NavigationDrawer(),
      body: Counselors_Page(),
    );
    
  }
}