import 'package:epal/Pages/GestionConteneurs.dart';
import 'package:epal/modules/modules.dart';
import 'package:epal/modules/employe.dart';
import 'package:epal/Pages/GestionEmployee.dart';
import 'package:epal/Pages/GestionModules.dart';
import 'package:epal/Pages/profile.dart';
import 'package:epal/icons.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RechercheEmploye extends StatefulWidget {
  static const String routeName = '/RechercheEmploye';

  @override
  State<RechercheEmploye> createState() => _RechercheEmployeState();
}

class _RechercheEmployeState extends State<RechercheEmploye> {
  final user = FirebaseAuth.instance.currentUser!;
  int nbr = employe.employees.length;
  @override
  void dispose() {
    super.dispose();
  }

  int _selectedIndex = 3;

  void reload() {
    setState(() {
      // refresh the current page
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to the home page
        Navigator.pushNamed(context, AdminHome.routeName);
        break;
      case 1:
        // Navigate to the search page
        Navigator.pushNamed(context, GestionModules.routeName);
        break;
      case 2:
        // Navigate to the containers page
        Navigator.pushNamed(context, GestionConteneurs.routeName);
        break;
      case 3:
        // Navigate to the employees page
        Navigator.pushNamed(context, GestionEmployee.routeName);
        break;
      case 4:
        // Navigate to the profile page
        Navigator.pushNamed(context, Profile.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFcbf2f2),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 50),
          Padding(
              child: Image.asset("assets/epal.png", width: 200, height: 150),
              padding: EdgeInsets.only(left: 0)),
          Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
            ),
          ),
          Container(
            width: 345.0,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                suffixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 345,
            height: 470,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      width: 370.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 13),
                            Center(
                                child: Column(
                              children: employe.employees
                                  .map((item) => Column(
                                        children: [
                                          SizedBox(
                                              height: 10), // add space here
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                            height: 98,
                                            width: 320,
                                            child: Row(
                                              children: [
                                                SizedBox(width: 5),
                                                Image.asset(
                                                  'assets/profil.png',
                                                  height: 55.0,
                                                  width: 55.0,
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  width: 140,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: 'ID: ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: item
                                                                          .EmployeID
                                                                      .toString(),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: 60),
                                                          RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: 'NCS: ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: '3',
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      RichText(
                                                        text: TextSpan(
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.black,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: 'NP: ',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: item.Nom
                                                                      .toString() +
                                                                  ' ' +
                                                                  item.Prenom
                                                                      .toString(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 60),
                                                Column(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                          Icons
                                                              .disabled_by_default_rounded,
                                                          color: Colors.red),
                                                      onPressed: () {
                                                        // Do something when the button is pressed
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.update),
                                                      onPressed: () {
                                                        // Do something when the button is pressed
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ))
                                  .toList(),
                            )),
                            SizedBox(
                              height: 15,
                            )
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Acceuil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.memory),
              label: 'Modules',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.container),
              label: 'Conteneurs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'employés',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}