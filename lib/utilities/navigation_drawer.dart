// ignore_for_file: prefer_const_constructors

import 'package:careapp/functionalities/appointments/appointment_list.dart';
import 'package:careapp/functionalities/calendar/calendar_page.dart';
import 'package:careapp/functionalities/counseling%20session/launch%20session.dart';
import 'package:careapp/functionalities/device_info.dart';
import 'package:careapp/functionalities/reports/reports_list.dart';
import 'package:careapp/functionalities/reports/reports.dart';
import 'package:careapp/screens/home/Counselee/counselee_list.dart';
import 'package:careapp/screens/home/Counselee/counselee_register.dart';
import 'package:careapp/screens/home/Counselor/counselor_register.dart';
import 'package:careapp/screens/home/Counselor/approve_session.dart';
import 'package:careapp/screens/home/Counselor/counselor_list.dart';
import 'package:careapp/screens/home/Counselor/counselors_page.dart';
import 'package:careapp/screens/home/Counselor/counselor_register.dart';
import 'package:careapp/screens/home/logout.dart';
import 'package:careapp/screens/home/user_account.dart';
import 'package:careapp/screens/home/user_page.dart';
import 'package:careapp/services/get_pending_session_approval_data.dart';
import 'package:careapp/utilities/drawer_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

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
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ReportsList()));
      break;
      //Notifications
      case 1:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> User_page()));
      break;

      case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AppointmentList()));
      break;

      case 3:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> CounselorList()));
      break;

      case 4:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> CounseleeList()));
      break;
      // Counselors
      case 5:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LaunchSession()));
      break;

      case 6:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Logout()));
      break;

      case 7:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CounseleeRegister()));
      break;

      case 8:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CounselorRegister()));
      break;

      case 9:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarPage()));
      break;

      case 10:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportsList()));
      break;
      

      // default:
      // Navigator.pop(context);
      // break;

    }
  }

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'Welcome',
                            style: personal,
                          ),
                          SizedBox(height: 10,),
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
          
                Divider(
                  height: 60,
                  color: Colors.white,
                ),
          
                // Drawer Items

                Text('Admin', style: TextStyle(color: Colors.white),),
                Divider(
                  height: 60,
                  color: Colors.white,
                ),

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
          
                DrawerItem(
                  Name: 'Chats', 
                  icon: Icons.chat, 
                  onPressed: ()=> onItemPressed(context, index: 2),
                ),
          
                const SizedBox(height: 20,),

                Text('Counselors', style: TextStyle(color: Colors.white),),
                Divider(
                  height: 60,
                  color: Colors.white,
                ),
          
                DrawerItem(
                  Name: 'Pending Approvals', 
                  icon: Icons.pending_actions, 
                  onPressed: ()=> onItemPressed(context, index: 2),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'All Counselors', 
                  icon: Icons.people, 
                  onPressed: ()=> onItemPressed(context, index: 3),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Register New Counselor', 
                  icon: Icons.app_registration, 
                  onPressed: ()=> onItemPressed(context, index: 8),
                ),
          
                const SizedBox(height: 20,),

                Text('Counselee', style: TextStyle(color: Colors.white),),

                Divider(
                  height: 60,
                  color: Colors.white,
                ),
          
                DrawerItem(
                  Name: 'All Counselee', 
                  icon: Icons.people_alt_rounded, 
                  onPressed: ()=> onItemPressed(context, index: 4),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Register New Counselee', 
                  icon: Icons.app_registration, 
                  onPressed: ()=> onItemPressed(context, index: 7),
                ),
          
                const SizedBox(height: 20,),

                Divider(
                  height: 60,
                  color: Colors.white,
                ),
          
                DrawerItem(
                  Name: 'Settings', 
                  icon: Icons.settings, 
                  onPressed: ()=> onItemPressed(context, index: 5),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Calendar', 
                  icon: Icons.calendar_month, 
                  onPressed: ()=> onItemPressed(context, index: 9),
                ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Reports', 
                  icon: Icons.book, 
                  onPressed: ()=> onItemPressed(context, index: 10),
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