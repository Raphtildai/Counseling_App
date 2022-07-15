import 'package:careapp/screens/authenticate/authentication.dart';
import 'package:careapp/utilities/neumorphicbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
        centerTitle: true,
      ),

      body:Center(
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(10),
          child: NeuBox(
            child: Column(
              children: [
                const Text(
                  'Are you sure you want to Logout?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        try{
                          // Loading
                          showDialog(
                            context: context, 
                            builder: (context){
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            );
                            // Pop out the loading widget
                            Navigator.of(context).pop();
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pop(MaterialPageRoute(builder: (context){
                            return const MainPage();
                          }));
                          showDialog(context: context, builder: (context){
                            return const AlertDialog(
                              content: Text('You have Logged Out'),
                            );
                          });
                          
                          
                          
                        }on FirebaseAuthException catch(e){
                          // Loading
                          showDialog(
                            context: context, 
                            builder: (context){
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          );
                          // Pop out the loading widget
                          Navigator.of(context).pop();
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              content: Text(e.message.toString()),
                            );
                          });
                        }
                      },
                      // },
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: NeuBox(
                          child: Text('Logout'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(context);
                        },
                        child: const NeuBox(
                          child: Text('Cancel'),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
   );
  }
}