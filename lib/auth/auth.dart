import 'package:firebase_auth/firebase_auth.dart';
import 'package:My_First_Flutter_App/auth/login_or_register.dart';
import 'package:My_First_Flutter_App/pages/home_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user logged in
          if (snapshot.hasData) {
            return HomePage();
          } else {
            // user NOT logged in
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
