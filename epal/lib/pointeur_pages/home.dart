import 'package:epal/constants/style.dart';
import 'package:epal/icons.dart';
import 'package:epal/pointeur_pages/conteneurs.dart';
import 'package:epal/pointeur_pages/home_page.dart';
import 'package:epal/pointeur_pages/lien.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:epal/chef_pages/notifications.dart';
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
  Color _buttonColor0 = Color(0xFF80CFCC);
  Color _buttonColor1 = Color(0xFF80CFCC);
  Color _buttonColor2 = Color(0xFF80CFCC);
  Color _buttonColor3 = Color(0xFF80CFCC);

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
                ? PointeurHomePage()
                : _selectedIndex == 1
                    ? Conteneurs()
                    : _selectedIndex == 2
                        ? Lien()
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
                SizedBox(width: 16),
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
                      _buttonColor3 = Color(0xFF80CFCC);
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
                SizedBox(width: 10),
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
                      _buttonColor3 = Color(0xFF80CFCC);
                    });
                  },
                  child: Container(
                    height: 41,
                    width: 80,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(MyFlutterApp.container),
                          ),
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
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                      _buttonColor0 =
                          Color(0xFF80CFCC); // Reset other buttons' colors
                      _buttonColor1 = Color(0xFF80CFCC);
                      _buttonColor2 =
                          dark; // Set the desired color for the clicked button
                      _buttonColor3 = Color(0xFF80CFCC);
                    });
                  },
                  child: Container(
                    height: 41,
                    width: 82,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.swap_horiz_outlined),
                          SizedBox(width: 2),
                          Text(' Dé/Attacher',
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
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor3,
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
                      _buttonColor2 = Color(0xFF80CFCC);
                      _buttonColor3 = dark; // Set the desired colo
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
