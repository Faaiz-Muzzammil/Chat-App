// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox({
    Key? key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  }) : super(key: key);
  
  final String text;
  final String sectionName;
  final void Function()? onPressed;  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName, style: TextStyle(color: Colors.grey[600]),),
              IconButton(
                onPressed: onPressed, 
                icon:const Icon(Icons.settings, color: Colors.black),
              )
            ],
          ),
          Text(text),
        ],
      ).p12(),
    );
  }
}
