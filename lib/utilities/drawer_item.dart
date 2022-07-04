import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {

  // Parameters to be passed to the drawer
  final String Name;
  final IconData icon;
  final Function() onPressed;

  final itemMenu = const TextStyle(
    fontSize: 14,
    color: Colors.white,
  );

  const DrawerItem({Key? key, required this.Name, required this.icon, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            // Icon
            Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
    
            // Name of the page
            Text(
              Name,
              style: itemMenu,
            )
          ],
        ),
      ),
    );
  }
}