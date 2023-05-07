import 'package:epal/icons.dart';
import 'package:epal/pointeur_pages/conteneurs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Pages/profile.dart';

class PointeurHome extends StatefulWidget {
  static const String routeName = '/pointeurhome';
  final user = FirebaseAuth.instance.currentUser;

  @override
  _PointeurHomeState createState() => _PointeurHomeState();
}

class _PointeurHomeState extends State<PointeurHome> {
  final user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      body: Container(
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 20.0,
            width: 350,
          ),
          Image.asset("assets/epal.png", width: 164, height: 120),
          Container(
            height: 558,
            child: _selectedIndex == 0
                ? Container(
                    color: Colors.red,
                  )
                : _selectedIndex == 1
                    ? Conteneurs()
                    : _selectedIndex == 2
                        ? Profile()
                        : Container(),
          ),
          SizedBox(
            height: 41,
          ),
          Container(
            height: 60,
            width: 600,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                SizedBox(width: 57),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF80CFCC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Container(
                    height: 41,
                    width: 50,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.home_outlined),
                          SizedBox(width: 2),
                          Text(' Home',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(width: 6),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF80CFCC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Container(
                    height: 41,
                    width: 80,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(MyFlutterApp.container),
                          SizedBox(width: 2),
                          Text(' Conteneurs',
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF80CFCC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: Container(
                    height: 41,
                    width: 50,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 2),
                          Text(' Profile',
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ]),
            ),
          )
        ])),
      ),
    );
  }
}
