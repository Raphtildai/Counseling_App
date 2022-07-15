// ignore_for_file: prefer_const_constructors

import 'package:careapp/functionalities/booking.dart';
import 'package:careapp/functionalities/settings_page.dart';
import 'package:careapp/screens/home/Counselor/counselors_page.dart';
import 'package:careapp/screens/home/logout.dart';
import 'package:careapp/screens/home/message.dart';
import 'package:careapp/screens/home/user_page.dart';
import 'package:careapp/utilities/drawer_item.dart';
import 'package:flutter/material.dart';

class CounseleeDrawer extends StatelessWidget {
CounseleeDrawer({ Key? key }) : super(key: key);

final personal = TextStyle(
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=> User_page()));
      break;
      //Notifications
      case 1:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> User_page()));
      break;

      case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Booking()));
      break;

      case 3:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Message()));
      break;

      case 4:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings_Page()));
      break;
      // Counselors
      case 5:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Counselors_page()));
      break;

      case 6:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Logout()));
      break;

      case 7:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings_Page()));
      break;
      

      // default:
      // Navigator.pop(context);
      // break;

    }
  }

  @override
  Widget build(BuildContext context){
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'Person Name',
                          style: personal,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'email@gmail.com',
                          style: personal
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10,),
          
                Divider(
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
                  Name: 'Book Session', 
                  icon: Icons.book, 
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
                  Name: 'Counselors', 
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