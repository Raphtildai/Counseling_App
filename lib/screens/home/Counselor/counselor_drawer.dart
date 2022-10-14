import 'package:careapp/functionalities/appointments/appointment_list.dart';
import 'package:careapp/functionalities/reports/reports_list.dart';
import 'package:careapp/functionalities/session_booking.dart';
import 'package:careapp/functionalities/settings_page.dart';
import 'package:careapp/screens/home/Counselee/counselee_list.dart';
import 'package:careapp/screens/home/Counselor/counselor_profile.dart';
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AppointmentList()));
      break;

      case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AppointmentList()));
      break;

      // case 3:
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> AppointmentList()));
      // break;

      case 4:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> CounseleeList()));
      break;
      // Counselors
      case 5:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Settings_Page()));
      break;

      case 6:
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Logout()));
      break;

      // Tracking counselee report

      case 7:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ReportsList()));
      break;

      // case 7:
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const Settings_Page()));
      // break;
      

      // default:
      // Navigator.pop(context);
      // break;

    }
  }

  @override
  Widget build(BuildContext context){
    final user = FirebaseAuth.instance.currentUser!;
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
                    const Icon(
                      Icons.person_pin,
                      color: Colors.white,
                      size: 60.0,
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
          
                DrawerItem(
                  Name: 'Pending Approvals', 
                  icon: Icons.pending, 
                  onPressed: ()=> onItemPressed(context, index: 2),
                ),
          
                // const SizedBox(height: 20,),
          
                // DrawerItem(
                //   Name: 'Reschedule Session', 
                //   icon: Icons.schedule, 
                //   onPressed: ()=> onItemPressed(context, index: 3),
                // ),
          
                const SizedBox(height: 20,),
          
                DrawerItem(
                  Name: 'Counselee List', 
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
                  Name: 'Track Counselee', 
                  icon: Icons.book_outlined, 
                  onPressed: ()=> onItemPressed(context, index: 7),
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