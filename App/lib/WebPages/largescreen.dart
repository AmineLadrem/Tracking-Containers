import 'package:epal/WebPages/LoginPage.dart';
import 'package:epal/constants/style.dart';
import 'package:epal/icons.dart';
import 'package:epal/widgets/conteneurs.dart';

import 'package:epal/widgets/home.dart';
import 'package:epal/WebPages/ipAddress.dart';
import 'package:epal/widgets/modules.dart';
import 'package:epal/widgets/map.dart';
import 'package:epal/widgets/profile.dart';
import 'package:epal/widgets/settings.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LargeScreen extends StatefulWidget {
  const LargeScreen({super.key});

  @override
  State<LargeScreen> createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  Future<http.Response> fetchAdmin(int id) {
    return http.get(Uri.parse(usedIPAddress + '/api/admin/$id'),
        headers: headers);
  }

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
                  height: 790.5,
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
                          width: 133,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.home_outlined),
                                SizedBox(width: 2),
                                Text(' Home',
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 6),
                              ],
                            ),
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
                          width: 133,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(MyFlutterApp.container),
                                SizedBox(width: 2),
                                Text('Conteneurs',
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 6),
                              ],
                            ),
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
                          width: 133,
                          child: Center(
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
                              ],
                            ),
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
                          width: 133,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.map, size: 16),
                                SizedBox(width: 4),
                                Text(' Carte Map',
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 8),
                              ],
                            ),
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
                            _selectedIndex = 5;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 133,
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.settings, size: 16),
                                SizedBox(width: 4),
                                Text(' Settings',
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                      /*SizedBox(height: 20),
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
                            _selectedIndex = 5;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_circle_down_outlined, size: 16),
                              SizedBox(width: 4),
                              Text('    Debarquement',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_circle_down_outlined, size: 16),
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
                            _selectedIndex = 6;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_circle_up_outlined, size: 16),
                              SizedBox(width: 4),
                              Text('   Embarquement',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_circle_up_outlined, size: 16),
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
                            _selectedIndex = 7;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.content_paste_search, size: 16),
                              SizedBox(width: 4),
                              Text('            Visite         ',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.content_paste_search, size: 16),
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
                            _selectedIndex = 8;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.send, size: 16),
                              SizedBox(width: 4),
                              Text('         Livraison      ',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.send, size: 16),
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
                            _selectedIndex = 9;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.move_up, size: 16),
                              SizedBox(width: 4),
                              Text('     Deplacement  ',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.move_down, size: 16),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),*/
                      SizedBox(height: 225),
                      Image.asset("assets/employee.png", width: 70, height: 70),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                          width: 290,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFF80CFCC),
                              width: 1.0,
                            ),
                          ),
                          child: FutureBuilder<http.Response>(
                            future: fetchAdmin(1),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final admin = jsonDecode(snapshot.data!.body);
                                return Padding(
                                  padding: const EdgeInsets.only(left: 7.0),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Nom:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${admin['Nom']}',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Prenom:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${admin['Prenom']}',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Role:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${admin['Role']}',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Adresse:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${admin['Adresse']}',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Telephone:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${admin['tel']}',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Shift:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${admin['Shift']}',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: dark,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Center(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
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
                          width: 133,
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.logout, size: 16),
                            SizedBox(width: 4),
                            Text('  Se déconnecter',
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold)),
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
                        ? GererModule()
                        : _selectedIndex == 3
                            ? map()
                            : _selectedIndex == 4
                                ? home()
                                : _selectedIndex == 5
                                    ? settings()
                                    : Container()),
      ],
    );
  }
}
