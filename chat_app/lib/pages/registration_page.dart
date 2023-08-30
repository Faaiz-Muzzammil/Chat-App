import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/text_field.dart';

class RegistrationPage extends StatefulWidget {
  final Function()? onTap;

  const RegistrationPage({super.key, required this.onTap});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  // User signup
  void signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ));

    // Notify Passwords not matched. 
    if (passwordTextController.text != confirmPasswordTextController.text){
      Navigator.pop(context);
      displayDialogue("OOPS! Passwords Do Not Match!");
      return;
    }

    // Create User.
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      // After Creating user, create a new doc in firestore (Users field).    
      FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.email).set(
        {
          "username": emailTextController.text.split('0')[0], // Set Username
          "bio" : "Empty Bio..." // Empty Bio Initially
        }
      );
      
      // Pop Loading Circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Display Message
      displayDialogue(e.code);
    }
  }

  // SHOW ERROR MESSAGE
  void displayDialogue(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(msg),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Stops the keyboard from causing an overflow.
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Icon(
                Icons.near_me_rounded,
                size: 140,
              ),
              0.heightBox,
              const Text(
                '𝕃𝕖𝕥\'𝕤 𝕊𝕖𝕥 𝕐𝕠𝕦 𝕌𝕡!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 36,
                    // fontFamily: ,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false),
              10.heightBox,
              MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true),
              10.heightBox,
              MyTextField(
                  controller: confirmPasswordTextController,
                  hintText: 'Confirm Password',
                  obscureText: true),
              10.heightBox,
              MyButton(
                onTap: signUp,
                text: "Sign Up",
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const SizedBox(width: 12),
                  const Text(
                    "Already part of the Fam? ",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Let's go!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ).py20(),
        ),
      )),
    );
  }
}
