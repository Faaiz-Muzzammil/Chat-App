import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // Firebase sign-in check.
  void signIn() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);

      // Pop Loading Circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Loading circle
      // Display Message
      displayDialogue(e.code);
    }
  }

  // Diplay Dialogue on Incorrect Login.
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
                height: 80,
              ),
              const Icon(
                Icons.near_me_rounded,
                size: 140,
              ),
              0.heightBox,
              const Text(
                '𝕎𝔼𝕃ℂ𝕆𝕄𝔼',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
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
              12.heightBox,
              MyButton(
                onTap: signIn,
                text: "Sign In",
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const SizedBox(width: 12,),
                  const Text(
                    "Haven't joined the party yet?",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Join Now",
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
