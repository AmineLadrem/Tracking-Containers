import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:epal/pages/home_page.dart';
import 'package:epal/pages/login_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      }),
    ));
  }
}
