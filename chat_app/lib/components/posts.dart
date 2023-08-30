import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/components/like_button.dart';

class Post extends StatefulWidget {
  const Post({
    Key? key,
    required this.msg,
    required this.user,
    required this.postId,
    required this.likes,
  }) : super(key: key);

  final String msg;
  final String user;
  final String postId;
  final List<String> likes;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser?.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection("User Posts").doc(widget.postId);
    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser?.email]),
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser?.email]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LikeButton(
                  isLiked: isLiked,
                  onTap: toggleLike,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.likes.length.toString())
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user,
                  style: TextStyle(color: Colors.grey[500]),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.msg,
                  softWrap: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
