import 'package:careapp/functionalities/session_booking.dart';
import 'package:careapp/functionalities/settings_page.dart';
import 'package:careapp/screens/home/Counselor/counselors_page.dart';
import 'package:careapp/screens/home/logout.dart';
import 'package:careapp/screens/home/message.dart';
import 'package:careapp/screens/home/user_account.dart';
import 'package:careapp/screens/home/user_page.dart';
import 'package:careapp/utilities/drawer_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CounselorDrawer extends StatelessWidget {
const CounselorDrawer({ Key? key }) : super(key: key);

final personal = const TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  // Function to take the user to the page they click
  void onItemPressed(BuildContext context, {required int index }){
    Navigator.pop(context);

    // Switch case
    switch(index){
      //Account
      case 0:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserAccount()));
      break;
      //Notifications
      case 1:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const User_page()));
      break;

      case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const SessionBooking()));
      break;

      case 3:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Message()));
      break;

      case 4:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Settings_Page()));
      break;
      // Counselors
      case 5:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Counselors_Page()));
      break;

      case 6:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Logout()));
      break;

      case 7:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Settings_Page()));
      break;
      

      // default:
      // Navigator.pop(context);
      // break;

    }
  }

  @override
  Widget build(BuildContext context){
    final user = FirebaseAuth.instance.currentUser!;
    // Url To the profile picture
    const url = 'https://photos.google.com/photo/AF1QipP-L6Wi5Ud3mPpdnmyy1dZrleOhYaIwyrkae6ju';
    return Drawer(
      child: Material(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Headers
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(url),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'Welcome',
                            style: personal,
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            '${user.email}',
                            style: personal
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
          
                const Divider(
                  height: 60,
                  color: Colors.white,
                ),
          
                const SizedBox(height: 10,),
          
                // Drawer Items
                DrawerItem(
                  Name: 'My Account', 
                  icon: Icons.account_box, 
                  onPressed: ()=> onItemPressed(context, index: 0),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Notifications', 
                  icon: Icons.notifications, 
                  onPressed: ()=> onItemPressed(context, index: 1),
                ),
          
                const SizedBox(height: 20,),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Pending Approvals', 
                  icon: Icons.pending, 
                  onPressed: ()=> onItemPressed(context, index: 2),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Chats', 
                  icon: Icons.chat, 
                  onPressed: ()=> onItemPressed(context, index: 2),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Reschedule Session', 
                  icon: Icons.schedule, 
                  onPressed: ()=> onItemPressed(context, index: 3),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Counselee', 
                  icon: Icons.people, 
                  onPressed: ()=> onItemPressed(context, index: 4),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Settings', 
                  icon: Icons.settings, 
                  onPressed: ()=> onItemPressed(context, index: 5),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Logout', 
                  icon: Icons.logout, 
                  onPressed: ()=> onItemPressed(context, index: 6),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}