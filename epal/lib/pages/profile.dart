import 'package:epal/icons.dart';
import 'package:epal/pages/home.dart';
import 'package:epal/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to the home page
        Navigator.pushNamed(context, AdminHome.routeName);
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
      body: Column(children: <Widget>[
        SizedBox(height: 50),
        Padding(
            child: Image.asset("assets/epal.png", width: 184, height: 140),
            padding: EdgeInsets.only(left: 0)),
        SizedBox(height: 50),
        Container(
          child: Stack(
            children: <Widget>[
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  height: 382.0,
                  width: 460.0,
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
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Employee ID: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '2002',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Nom: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Ladrem',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Prenom: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Amine',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Role: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'ksh haja wla haja',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Adresse: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'ksh haja',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'E-Mail: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: user!.email!,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Tel: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '+213xxxxxx',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Shift-Curret: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Nuit',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginPage.routeName,
                              (_) =>
                                  false, // Remove all routes except the login page
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF8FABFE)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text(
                            '  Se déconnecter  ',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
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
                  translation: Offset(-0.0, -0.5),
                  child: Image.asset(
                    'assets/employee.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ),
            ],
          ),
        ),
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
