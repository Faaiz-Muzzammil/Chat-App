import 'package:chat_app/components/my_text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text("P R O F I L E")
        ),
        body: ListView(
          children: [
            const SizedBox(
            height: 50,
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "My Details",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 23,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.start,
            ),
          ),

          // Username Field.
          MyTextBox(
            text: currentUser.email!,
            sectionName: "username",
            onPressed: () => editField("Username"),
          ),

          // Bio Field.
          MyTextBox(
            text: "Empty...",
            sectionName: "bio",
            onPressed: () => editField("Bio"),
          ),
          20.heightBox,
          ],
        ),
    );          
}
}