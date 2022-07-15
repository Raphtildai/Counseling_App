// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetCounseleeData extends StatelessWidget {
  final String documentIds;

  const GetCounseleeData({required this.documentIds});

  @override
  Widget build(BuildContext context) {
    // Get collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentIds).get(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          Map <String, dynamic> data = 
          snapshot.data!.data() as Map <String, dynamic>;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Name
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Name:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    '${data['firstname']}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Text('${data['lastname']}'),
                ],
              ),

              const SizedBox(height: 10,),

              // Registration number
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Reg. No:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    '${data['regnumber']}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10,),


              // email
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Text(
                      '${data['email']}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10,),

              // phone number
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Phone Number:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    '${data['pnumber']}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10,),

              // Role
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Role:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    '${data['role']}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10,),
            //   Text(
            // '${data['firstname']} ' + '${data['lastname']}, '
            //  + '${data['regnumber']}'
            //  )
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}