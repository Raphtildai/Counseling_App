import 'package:careapp/screens/authenticate/auth.dart';
import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/screens/home/Counselee/counselee_home.dart';
import 'package:careapp/screens/home/Counselee/counselee_list.dart';
import 'package:careapp/screens/home/Counselor/counselor_home.dart';
import 'package:careapp/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRoles extends StatelessWidget {
  CollectionReference counselee = FirebaseFirestore.instance.collection('users');
    Future getdocID() async {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: uid).get().then(
        (snapshot) => snapshot.docs.forEach((document) {
          if(ConnectionState == ConnectionState.done){
            CollectionReference docid = FirebaseFirestore.instance.collection('users');
            String doc = document.reference.id;
            var result = docid.doc(doc).get();
            print(result);
            FutureBuilder <DocumentSnapshot>(
              future: result,
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                // Error handling conditions
                if(snapshot.hasError){
                  // print(docid);
                  print(snapshot.error);
                  return const Center(child: Text('Something went Wrong'));
                }
                if(snapshot.hasData && !snapshot.data!.exists){
                  // print(FirebaseAuth.instance.currentUser?.email);
                  // print(docid);
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      content: Text('The User Record does not exist'),
                    );
                  });
                  // return const Center(child: Text('The User Record does not exist'),);
                }

                // Outputting the data to the user
                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                  if(data['role'] == 'admin'){
                    return Home();
                  }else if(data['role'] == 'counselee'){
                    return const CounseleeHome();
                  }else if(data['role'] == 'counselor'){
                    return const CounselorHome();
                  }else{
                    return CounseleeList();
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            );

            
            
          // }else if(ConnectionState == ConnectionState.waiting){
          // showDialog(context: context, builder: (context){
          //   return AlertDialog(
          //     content: Text('Signing you in based on your user role'),
          //   );
          // });
          }
        }));
    }

  @override
  Widget build(BuildContext context){
    return AuthPage();
  }
}