import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Text("profile"),
    );
  }
}
