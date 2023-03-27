import 'package:epal/Pages/GestionEmployee.dart';
import 'package:epal/Pages/GestionModules.dart';
import 'package:epal/Pages/profile.dart';
import 'package:epal/icons.dart';
import 'package:epal/pages/GestionConteneurs.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class DateTextInputFormatter extends TextInputFormatter {
  final String formatPattern = 'dd/MM/yyyy';
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String oldText = oldValue.text.replaceAll('/', '');
    String newText = newValue.text.replaceAll('/', '');
    int selectionIndex = newValue.selection.end;
    String formatted = '';

    for (int i = 0; i < newText.length; i++) {
      if (i == 2 || i == 4) {
        formatted += '/';
      }
      formatted += newText[i];
    }

    // Handle selection index adjustments
    if (oldText.length < newText.length) {
      // User typed a new character
      selectionIndex += formatted.length - newValue.text.length;
    } else {
      // User deleted a character
      selectionIndex -= oldText.length - newText.length;
    }
    selectionIndex = selectionIndex.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class AjoutConteneur extends StatefulWidget {
  static const String routeName = '/AjoutConteneur';

  @override
  State<AjoutConteneur> createState() => _AjoutConteneurState();
}

class _AjoutConteneurState extends State<AjoutConteneur> {
  final user = FirebaseAuth.instance.currentUser!;
  final ContID = TextEditingController();
  final ContType = TextEditingController();
  final ContDateArrPr = TextEditingController();
  final ContDateArr = TextEditingController();
  final status = TextEditingController();
  final EmployeID = TextEditingController();
  final ModuleID = TextEditingController();

  @override
  void dispose() {
    ContID.dispose();
    ContType.dispose();
    ContDateArrPr.dispose();
    ContDateArr.dispose();
    status.dispose();
    EmployeID.dispose();
    ModuleID.dispose();
    super.dispose();
  }

  int _selectedIndex = 2;

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
              child: Image.asset("assets/epal.png", width: 200, height: 85),
              padding: EdgeInsets.only(left: 0)),
          Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
            ),
          ),
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
                    height: 470.0,
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
                        Center(
                          child: Text(
                            'Ajout D’un Conteneur',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 19),
                        Center(
                          child: Container(
                            height: 50,
                            width: 300,
                            child: TextField(
                              controller: ContID,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Conteneur ID',
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
                              controller: ContType,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Type de Conteneur',
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
                              controller: ContDateArrPr,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Date d\'arrive prevue ',
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
                              controller: ContDateArr,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Date d\'arrive',
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
                                labelText: 'Status',
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
                              controller: EmployeID,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Employe ID *',
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
                              controller: ModuleID,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Module ID *',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
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
                      'assets/container.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
              child: SizedBox(
            width: 200.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  GestionConteneurs.routeName,
                  (_) => false, // Remove all routes except the login page
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF8FABFE)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              child: Text(
                '  Ajouter  ',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          )),
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
