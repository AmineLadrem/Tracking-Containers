import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:epal/WebPages/dashboard.dart';
import 'package:epal/WebPages/ipAddress.dart';
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
  bool userNotFound = false;
  bool wrongPassword = false;
  bool role = false;
  Future<void> signIn() async {
    print(usedIPAddress + '/api/utilisateur/' + emailController.text.trim());

    var response = await http.get(
      Uri.parse(
          usedIPAddress + '/api/utilisateur/' + emailController.text.trim()),
      headers: headers,
    );
    print(response);
    var user = json.decode(response.body);
    print(user);
    if (user['E-mail'] == emailController.text.trim()) {
      userNotFound = false;
      if (user['MotPass'] == PasswordController.text.trim()) {
        wrongPassword = false;
        if (user['Role'] == 'admin') {
          role = false;
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: PasswordController.text.trim(),
          );

          Navigator.pushNamed(context, Dashboard.routeName);
        } else {
          print('You don\'t have access');
          role = true;
        }
      } else {
        print('Wrong password');
        wrongPassword = true;
      }
    } else {
      print('User not found');
      userNotFound = true;
    }

    // Update the UI to display the error messages
    setState(() {
      this.userNotFound = userNotFound;
      this.wrongPassword = wrongPassword;
      this.role = role;
    });
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
                    padding: const EdgeInsets.only(bottom: 140),
                    child: Text(
                      'Gestion des Conteneurs de l\'EPAL',
                      style: TextStyle(
                        color: Color(0xFF02558F),
                        fontFamily: 'Urbanist',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 1),
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
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Mot de passe',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: userNotFound,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        'L\'utilisateur n\'existe pas',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: role,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        'Vous n\'avez pas le droit d\'accès',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: wrongPassword,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        'Mot de passe incorrect',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: signIn,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFC7F5F5),
                                    minimumSize: Size(310, 50),
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
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
