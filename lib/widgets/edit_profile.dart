import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart';
// import 'package:pdf/widgets.dart';

Widget <edit_profile>(BuildContext context) {
  final _fnamecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text('Edit your profile'),
      content: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _fnamecontroller,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text('Update'),
        ),
        MaterialButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  });
}