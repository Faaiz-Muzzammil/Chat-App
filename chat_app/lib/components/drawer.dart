// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
    required this.onProfileTap,
  }) : super(key: key);
  final void Function()? onProfileTap;

// Logout!
void signOut() {
    FirebaseAuth.instance.signOut();
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.message, 
              color: Colors.white, 
              size: 120,
            ),
          ),
          
          // Home Tile
          MyListTile(
            icon: Icons.home, 
            text: "H O M E",
            onTap: () => Navigator.pop(context),
          ),

          // Profile Tile
          MyListTile(
            icon: Icons.info, 
            text: "P R O F I L E",
            onTap: onProfileTap,
          ),

          // Logout Tile
          MyListTile(
            icon: Icons.logout, 
            text: "L O G O U T",
            onTap: signOut,
          )
        ],
      ),
    );
  }
}
