import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static const String routeName = '/adminhome';
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Color(0xFFE1E2E2),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Color(0xFFEAF6F6),
            child: Column(children: <Widget>[
              SizedBox(
                height: 10.0,
                width: 350,
              ),
              Image.asset("assets/epal.png", width: 184, height: 140),
              Image.asset("assets/navire.png", width: 321, height: 397),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Text('Sign out'))
            ]),
          ),
        )),
      ),
    );
  }
}
