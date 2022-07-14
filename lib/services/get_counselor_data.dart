import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetCounselorData extends StatelessWidget {
final String documentIds;

  GetCounselorData({required this.documentIds});

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
                  Text(
                    'Name:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    '${data['firstname'] + data['lastname']}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              // Registration number
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reg. No:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    '${data['regnumber']}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),


              // email
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Text(
                      '${data['email']}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              // phone number
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Phone Number:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    '${data['pnumber']}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              // Role
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Role:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    '${data['role']}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),
            //   Text(
            // '${data['firstname']} ' + '${data['lastname']}, '
            //  + '${data['regnumber']}'
            //  )
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}