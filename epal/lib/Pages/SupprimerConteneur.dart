import 'package:epal/icons.dart';
import 'package:epal/pages/GestionConteneurs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:epal/auth.dart';

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

class SupprimerConteneur extends StatefulWidget {
  static const String routeName = '/SupprimerConteneur';

  @override
  State<SupprimerConteneur> createState() => _SupprimerConteneurState();
}

class _SupprimerConteneurState extends State<SupprimerConteneur> {
  final user = FirebaseAuth.instance.currentUser!;
  final _ConteneurController = TextEditingController();
  final _ConteneurTypeController = TextEditingController();
  final _ConteneurDateDController = TextEditingController();

  @override
  void dispose() {
    _ConteneurController.dispose();
    _ConteneurDateDController.dispose();
    _ConteneurTypeController.dispose();
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
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        // Navigate to the search page
        Navigator.pushNamed(context, '/modules');
        break;
      case 2:
        // Navigate to the containers page
        Navigator.pushNamed(context, '/GestionConteneurs');
        break;
      case 3:
        // Navigate to the employees page
        Navigator.pushNamed(context, '/employees');
        break;
      case 4:
        // Navigate to the profile page
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFcbf2f2),
      body: Column(children: <Widget>[
        SizedBox(height: 50),
        Padding(
            child: Image.asset("assets/epal.png", width: 200, height: 180),
            padding: EdgeInsets.only(left: 0)),
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 30, bottom: 30),
            child: Text(
              'Supprimer un Conteneur',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          width: 345,
          height: 300,
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Conteneur ID*: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 35),
                            SizedBox(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '158465 ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Conteneur Type: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 22),
                            SizedBox(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '40P',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'DatePrevueArrivée: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '20/12/2023',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Date arrivée: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 50),
                            SizedBox(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '30/12/2023',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Status: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 92),
                            SizedBox(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'En Inspection',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'ID Employee*: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 38),
                            SizedBox(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '655132',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Module ID*: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 55),
                            SizedBox(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '6545865',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: FractionalTranslation(
                  translation: Offset(-0.2, -0.7),
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
        SizedBox(height: 30.0),
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
              '  Supprimer  ',
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
