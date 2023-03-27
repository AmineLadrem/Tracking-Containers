import 'package:epal/Pages/AjoutConteneur.dart';
import 'package:epal/Pages/GestionConteneurs.dart';
import 'package:epal/Pages/GestionEmployee.dart';
import 'package:epal/Pages/ModifierConteneur.dart';
import 'package:epal/Pages/SupprimerConteneur.dart';
import 'package:epal/Pages/profile.dart';
import 'package:epal/icons.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:flutter/material.dart';

class GestionModules extends StatefulWidget {
  static const String routeName = '/modules';
  @override
  State<GestionModules> createState() => _GestionModulesState();
}

class _GestionModulesState extends State<GestionModules> {
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
            Image.asset("assets/Modules.png", width: 400, height: 200),
            SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 300, // Set the desired width here
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AjoutConteneur()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.place),
                        SizedBox(width: 7),
                        Text('Ajouter Un Module de suivie '),
                        SizedBox(width: 7),
                        Icon(Icons.place),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300, // Set the desired width here
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModifierConteneur()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.place),
                        SizedBox(width: 7),
                        Text('Modifier Un Module de suivie'),
                        SizedBox(width: 7),
                        Icon(Icons.place),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300, // Set the desired width here
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupprimerConteneur()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.place),
                        SizedBox(width: 7),
                        Text('Supprimer Un Module de suivie'),
                        SizedBox(width: 7),
                        Icon(Icons.place),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
          ]),
        )),
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
