import 'package:epal/conducteur_pages/home_page.dart';
import 'package:epal/conducteur_pages/liste_demandes.dart';
import 'package:epal/constants/style.dart';
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
  Color _buttonColor0 = Color(0xFF80CFCC);
  Color _buttonColor1 = Color(0xFF80CFCC);
  Color _buttonColor2 = Color(0xFF80CFCC);

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
                ? ConducteurHomePage()
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
                    backgroundColor: _buttonColor0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                      _buttonColor0 =
                          dark; // Set the desired color for the clicked button
                      _buttonColor1 =
                          Color(0xFF80CFCC); // Reset other buttons' colors
                      _buttonColor2 = Color(0xFF80CFCC);
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
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 35),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                      _buttonColor0 =
                          Color(0xFF80CFCC); // Reset other buttons' colors
                      _buttonColor1 =
                          dark; // Set the desired color for the clicked button
                      _buttonColor2 = Color(0xFF80CFCC);
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
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 35),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                      _buttonColor0 =
                          Color(0xFF80CFCC); // Reset other buttons' colors
                      _buttonColor1 = Color(0xFF80CFCC);
                      _buttonColor2 = dark; // Set
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
