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

class AjoutConteneur extends StatefulWidget {
  static const String routeName = '/AjoutConteneur';

  @override
  State<AjoutConteneur> createState() => _AjoutConteneurState();
}

class _AjoutConteneurState extends State<AjoutConteneur> {
  final user = FirebaseAuth.instance.currentUser!;
  final _ConteneurController = TextEditingController();
  final _ConteneurTypeController = TextEditingController();
  final _ConteneurDateDController1 = TextEditingController();
  final _ConteneurDateDController2 = TextEditingController();
  @override
  void dispose() {
    _ConteneurController.dispose();
    _ConteneurDateDController1.dispose();
    _ConteneurDateDController2.dispose();
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
            child: Image.asset("assets/epal.png", width: 200, height: 85),
            padding: EdgeInsets.only(left: 0)),
        Center(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Ajout D’un Conteneur',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                              width: 170,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: _ConteneurController,
                                  decoration: InputDecoration(
                                    hintText: 'Entrer le ID..',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                  ),
                                  maxLines:
                                      1, // set to null to allow unlimited lines
                                  keyboardType: TextInputType
                                      .number, // allow multiline input
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
                              width: 170,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: _ConteneurTypeController,
                                  decoration: InputDecoration(
                                    hintText: 'Entrer le Type..',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal:
                                            5), // adjust these values as needed
                                  ),
                                  maxLines: 1, //
                                  keyboardType: TextInputType.text,
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
                              width: 170,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: _ConteneurDateDController1,
                                  inputFormatters: [DateTextInputFormatter()],
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    labelText: 'Date Prevue d’arrivée',
                                    hintText: 'dd/mm/yyyy',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                  ),
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
                              width: 170,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: _ConteneurDateDController2,
                                  inputFormatters: [DateTextInputFormatter()],
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    labelText: 'Date Arrive..',
                                    hintText: 'dd/mm/yyyy',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                  ),
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
                              width: 170,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: _ConteneurTypeController,
                                  decoration: InputDecoration(
                                    hintText: 'Entrer le Status..',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal:
                                            5), // adjust these values as needed
                                  ),
                                  maxLines: 1, //
                                  keyboardType: TextInputType.text,
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
                              width: 170,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: _ConteneurTypeController,
                                  decoration: InputDecoration(
                                    hintText: 'Entrer le ID Employee..',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal:
                                            5), // adjust these values as needed
                                  ),
                                  maxLines: 1, //
                                  keyboardType: TextInputType.text,
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
                              width: 170,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: _ConteneurTypeController,
                                  decoration: InputDecoration(
                                    hintText: 'Entrer le ID du Module..',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal:
                                            5), // adjust these values as needed
                                  ),
                                  maxLines: 1, //
                                  keyboardType: TextInputType.text,
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
