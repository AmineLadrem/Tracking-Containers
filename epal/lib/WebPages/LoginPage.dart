import 'package:epal/WebPages/largescreen.dart';
import 'package:epal/WebPages/smallscreen.dart';
import 'package:epal/helpers/responsive.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WebLoginPage extends StatefulWidget {
  static const String routeName = '/login';
  @override
  State<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();

  Future<void> signIn() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: PasswordController.text.trim(),
      );
      // If sign-in was successful, navigate to the home page
      Navigator.pushNamed(context, AdminHome.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFEAF6F6),
        body: ResponsiveWidget(
            largeScreen: LargeScreen(), smallScreen: SmallScreen()),
      ),
    );
  }
}
