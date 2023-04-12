import 'package:epal/WebPages/LoginPage.dart';
import 'package:epal/constants/style.dart';
import 'package:epal/icons.dart';
import 'package:epal/widgets/conteneurs.dart';
import 'package:epal/widgets/home.dart';
import 'package:epal/widgets/modules.dart';
import 'package:epal/widgets/notifications.dart';
import 'package:epal/widgets/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatefulWidget {
  const LargeScreen({super.key});

  @override
  State<LargeScreen> createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  int _selectedIndex = 4;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: back,
          child: Column(
            children: [
              Card(
                child: Container(
                  width: 220,
                  height: 681.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80CFCC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 4;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.home_outlined),
                              SizedBox(width: 2),
                              Text('         Home       ',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 6),
                              Icon(Icons.home_outlined),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80CFCC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(MyFlutterApp.container),
                              SizedBox(width: 2),
                              Text('    Conteneurs    ',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 6),
                              Icon(MyFlutterApp.container),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80CFCC),
                          // elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.gps_fixed, size: 16),
                              SizedBox(width: 4),
                              Text('Tracker_Module',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.gps_fixed, size: 16),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80CFCC),
                          // elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 3;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.notifications, size: 16),
                              SizedBox(width: 4),
                              Text('     Notifications   ',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.notifications, size: 16),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 400),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80CFCC),
                          // elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person, size: 16),
                              SizedBox(width: 4),
                              Text('           Profile          ',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.person, size: 16),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80CFCC),
                          // elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            WebLoginPage.routeName,
                            (_) =>
                                false, // Remove all routes except the login page
                          );
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.logout, size: 16),
                            SizedBox(width: 4),
                            Text('Se déconnecter',
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Icon(Icons.logout, size: 16),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
        Expanded(
            flex: 5,
            child: _selectedIndex == 0
                ? profile()
                : _selectedIndex == 1
                    ? containers()
                    : _selectedIndex == 2
                        ? modules()
                        : _selectedIndex == 3
                            ? notifications()
                            : _selectedIndex == 4
                                ? home()
                                : Container())
      ],
    );
  }
}
