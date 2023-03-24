import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static const String routeName = '/adminhome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1E2E2),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(),
        )),
      ),
    );
  }
}
