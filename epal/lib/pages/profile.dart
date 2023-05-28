import 'package:epal/constants/style.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:epal/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  Future<http.Response> fetchUser(String email) {
    return http.get(Uri.parse(usedIPAddress + '/api/utilisateur/$email'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      child: Row(
        children: [
          FutureBuilder<http.Response>(
            future: fetchUser(user.email!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final utilisateur = jsonDecode(snapshot.data!.body);
                return Padding(
                  padding: const EdgeInsets.only(top: 65.0),
                  child: Column(children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
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
                                    width: 380,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 150.0),
                                      child: Text(
                                        'Profile',
                                        style: TextStyle(
                                          fontSize: 27.0,
                                          fontFamily: 'Urbanist',
                                          color: dark,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 75.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(7.0),
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'Urbanist',
                                                color: dark,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Employee ID: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: utilisateur['ID']
                                                      .toString(),
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
                                                fontFamily: 'Urbanist',
                                                color: dark,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Nom: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: utilisateur['Nom'],
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
                                                fontFamily: 'Urbanist',
                                                color: dark,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Prenom: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: utilisateur['Prenom'],
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
                                                fontFamily: 'Urbanist',
                                                color: dark,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Role: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: utilisateur['Role'],
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
                                                fontFamily: 'Urbanist',
                                                color: dark,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Adresse: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: utilisateur['Adresse'],
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
                                                fontFamily: 'Urbanist',
                                                color: dark,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'E-Mail: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: user.email!,
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
                                                fontFamily: 'Urbanist',
                                                color: dark,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Tel: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: utilisateur['tel']
                                                      .toString(),
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
                                                fontFamily: 'Urbanist',
                                                color: dark,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Shift-Current: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: utilisateur['Shift'],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 67.0),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF80CFCC)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '  Changer le mot de passe ',
                                            style: TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 100.0),
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
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF80CFCC)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '  Se déconnecter  ',
                                            style: TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 23,
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
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 120.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Color(0xFF80CFCC),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
