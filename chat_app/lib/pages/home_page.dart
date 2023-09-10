import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();

  // Writing Text
  void sendText() {
    if (textController.text.isNotEmpty) {
      //Store Data in Firebase
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser?.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }

    // clear the textfield
    setState(() {
      textController.clear();
    });
  }

  // Navigate to profile page.
  void goToProfilePage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
      ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('C H A T R',).shimmer(primaryColor: Colors.black, secondaryColor: Vx.gray300),
      ),
      body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .orderBy("TimeStamp", descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final post = snapshot.data!.docs;
                    if (snapshot.data != null && post.length > index) {
                      final posts = post[index];
                      final isOutgoing =
                          currentUser?.email == posts['UserEmail'];

                      return AnimatedOpacity(
                        duration: const Duration(
                            milliseconds: 500), // Adjust the duration as needed
                        opacity: 1.0, // Set to 0.0 initially to make it fade in
                        child: Align(
                          alignment: isOutgoing
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isOutgoing ? Colors.black : Colors.green,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              posts['Message'] ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ).px(12),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        Row(
          children: [
            Expanded(
                child: MyTextField(
                    controller: textController,
                    hintText: "Start writing!",
                    obscureText: false)),
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: IconButton(
                alignment: Alignment.bottomRight,
                onPressed: sendText,
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                  
                ).p4(),
              ),
            )
          ],
        ).p16(),
      ])),
    );
  }
}
