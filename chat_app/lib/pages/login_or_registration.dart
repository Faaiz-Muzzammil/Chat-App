import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/registration_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegistration extends StatefulWidget {
  const LoginOrRegistration({super.key});

  @override
  State<LoginOrRegistration> createState() => _LoginOrRegistrationState();
}

class _LoginOrRegistrationState extends State<LoginOrRegistration> {
  bool showLoginPage = true;
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegistrationPage(onTap: togglePages);
    }
  }
}
