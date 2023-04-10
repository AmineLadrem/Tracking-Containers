import 'package:epal/WebPages/largescreen.dart';
import 'package:epal/WebPages/smallscreen.dart';
import 'package:epal/helpers/responsive.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WebLoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();

  Future<void> signIn() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: PasswordController.text.trim(),
      );
      // If sign-in was successful, navigate to the home page
      Navigator.pushNamed(context, AdminHome.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final double pi = 3.14159265358979323846;
    return Material(
      child: Container(
        height: 500,
        width: 500,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF91DBC5),
              Color(0xFFBCEBFF),
            ],
            stops: [
              0.0, // Start position
              1.0, // End position
            ],
            transform: GradientRotation(353.99 * (pi / 180)),
          ),
        ),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 220),
                        child: Image.asset("assets/epal.png",
                            width: 300, height: 220),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 170),
                        child: Image.asset("assets/port.png",
                            width: 576, height: 433),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 270,
              ),
              Column(
                children: [
                  Text(
                    'Bienvenue sur la plateforme',
                    style: TextStyle(
                      color: Color(0xFF02558F),
                      fontFamily: 'Urbanist',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'de',
                    style: TextStyle(
                      color: Color(0xFF02558F),
                      fontFamily: 'Urbanist',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 130),
                    child: Text(
                      'Gestion des Contneurs de l\'EPAL',
                      style: TextStyle(
                        color: Color(0xFF02558F),
                        fontFamily: 'Urbanist',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  Stack(
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
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFB9EAFB),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 45),
                              Center(
                                child: Container(
                                  color: Colors.white,
                                  height: 50,
                                  width: 300,
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Identifiant',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Center(
                                child: Container(
                                  color: Colors.white,
                                  height: 50,
                                  width: 300,
                                  child: TextField(
                                    controller: PasswordController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Mot de passe',
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
                                    backgroundColor: Color(0xFFC7F5F5),
                                    minimumSize: Size(250, 50),
                                    side: BorderSide(
                                        color: Color(0xFF20B6C7), width: 2),
                                  ),
                                  child: Text(
                                    'Se Connecter',
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
                        alignment: Alignment.topRight,
                        child: FractionalTranslation(
                          translation: Offset(2.3, -0.5),
                          child: Image.asset(
                            'assets/ship.png',
                            width: 120.0,
                            height: 120.0,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
