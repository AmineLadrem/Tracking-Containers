import 'dart:convert';
import 'dart:io';
import 'package:epal/modules/employe.dart';
import 'package:http/http.dart' as http;
import 'package:epal/Pages/GestionConteneurs.dart';

import 'package:epal/Pages/GestionModules.dart';
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
      case 1:
        // Navigate to the search page
        Navigator.pushNamed(context, GestionModules.routeName);
        break;
      case 2:
        // Navigate to the containers page
        Navigator.pushNamed(context, GestionConteneurs.routeName);
        break;

      case 4:
        // Navigate to the profile page
        Navigator.pushNamed(context, Profile.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<employe> getUser(String email) async {
      final String url =
          Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';
      var response =
          await http.get(Uri.parse(url + '/api/utilisateur/' + email));

      // Parse the JSON response
      var data = json.decode(response.body);
      employe user = new employe(
          data['ID'],
          data['Nom'],
          data['Prenom'],
          data['Role'],
          data['Adresse'],
          data['tel'],
          data['E-mail'],
          data['MotPass']);

      return user;
    }

    final user = FirebaseAuth.instance.currentUser;
    Future<employe> utilisateur = getUser(user!.email!);

    // When the data is available, print it.
    utilisateur.then((employe) {
      print('ID: ${employe.ID}');
      print('Nom: ${employe.Nom}');
      print('Prenom: ${employe.Prenom}');
      print('Role: ${employe.Role}');
      print('Adresse: ${employe.Adresse}');
      print('tel: ${employe.tel}');
      print('Email: ${employe.Email}');
      print('Password: ${employe.Password}');
    });

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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GestionConteneurs()),
                        );
                      },
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GestionModules()),
                      );
                    },
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
