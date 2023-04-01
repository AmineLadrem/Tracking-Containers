import 'package:epal/Pages/GestionConteneurs.dart';
import 'package:epal/Pages/GestionEmployee.dart';
import 'package:epal/Pages/GestionModules.dart';
import 'package:epal/Pages/profile.dart';
import 'package:epal/icons.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AjoutModule extends StatefulWidget {
  static const String routeName = '/AjoutModule';

  @override
  State<AjoutModule> createState() => _AjoutModuleState();
}

class _AjoutModuleState extends State<AjoutModule> {
  final user = FirebaseAuth.instance.currentUser!;
  final status = TextEditingController();
  final ModuleID = TextEditingController();

  @override
  void dispose() {
    status.dispose();
    ModuleID.dispose();
    super.dispose();
  }

  int _selectedIndex = 1;

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
          SizedBox(height: 10),
          Text(
            'Ajout D\'un Module de suivie',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          Container(
            width: 345,
            height: 470,
            child: Stack(
              children: <Widget>[
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 270.0,
                    width: 370.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
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
                        SizedBox(height: 45),
                        Center(
                          child: Container(
                            height: 50,
                            width: 300,
                            child: TextField(
                              controller: ModuleID,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Module ID',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Container(
                            height: 50,
                            width: 300,
                            child: TextField(
                              controller: status,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Status de module',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1F485B),
                              minimumSize: Size(250, 40),
                            ),
                            child: Text(
                              'Ajouter',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: FractionalTranslation(
                    translation: Offset(-0.2, -0.5),
                    child: Image.asset(
                      'assets/gpsModule.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: FractionalTranslation(
                    translation: Offset(0.2, -0.5),
                    child: Image.asset(
                      'assets/location.png',
                      width: 100.0,
                      height: 100.0,
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
