import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LikeButton extends StatelessWidget {
  
  final bool isLiked;
  void Function()? onTap;

  LikeButton({
    Key? key,
    required this.isLiked,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked? Icons.favorite: Icons.favorite_border,
        color: isLiked ? Colors.black : Colors.grey,
      ),
    );
  }
}
