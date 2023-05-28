import 'package:epal/chef_pages/demandes.dart';
import 'package:epal/chef_pages/notifications.dart';
import 'package:epal/conducteur_pages/liste_demandes.dart';
import 'package:epal/icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Pages/profile.dart';

class ConducteurHome extends StatefulWidget {
  static const String routeName = '/ConducteurHome';
  final user = FirebaseAuth.instance.currentUser;

  @override
  _ConducteurHomeState createState() => _ConducteurHomeState();
}

class _ConducteurHomeState extends State<ConducteurHome> {
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
                ? notifications()
                : _selectedIndex == 1
                    ? ListeDemandesCond()
                    : _selectedIndex == 3
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
                SizedBox(width: 60),
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
                SizedBox(width: 35),
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
                    width: 75,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.directions),
                          SizedBox(width: 2),
                          Text(' Demandes',
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
                SizedBox(width: 35),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF80CFCC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
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