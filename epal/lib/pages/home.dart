import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:epal/Pages/profile.dart';
import 'package:epal/icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  static const String routeName = '/adminhome';
  final user = FirebaseAuth.instance.currentUser;

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to the home page
        Navigator.pushNamed(context, AdminHome.routeName);
        break;

      case 4:
        // Navigate to the profile page
        Navigator.pushNamed(context, Profile.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<bool> _visible = [true, true, true, true, true];

    // Define the getUser function as async
    Future<String> getUser(String email) async {
      final String url =
          Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';
      var response =
          await http.get(Uri.parse(url + '/api/utilisateur/' + email));
      var user = json.decode(response.body);
      print(user);
      return user;
    }

    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            SizedBox(
              height: 10.0,
              width: 350,
            ),
            Image.asset("assets/epal.png", width: 184, height: 140),
            Image.asset("assets/navire.png", width: 400, height: 300),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  child: SizedBox(
                    width: 260, // Set the desired width here
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(MyFlutterApp.container),
                          Text('Gestion Des Conteneurs'),
                          SizedBox(width: 7),
                          Icon(MyFlutterApp.container),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 260, // Set the desired width here
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.people_outline),
                        SizedBox(width: 7),
                        Text('Gestion Des Employés'),
                        SizedBox(width: 7),
                        Icon(Icons.people_outline),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 260, // Set the desired width here
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.place_outlined),
                        Text('Gestion Des Modules'),
                        SizedBox(width: 7),
                        Icon(Icons.place_outlined),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ]),
        )),
      ),
    );
  }
}
