// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final Function()? onTap;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        onTap: onTap,
        title: Text(
          text, 
          style:const TextStyle(
            color: Colors.white,
            ),
          ),
      ),
    );
  }
}
