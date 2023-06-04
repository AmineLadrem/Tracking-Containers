import 'dart:convert';
import 'package:epal/WebPages/ipAddress.dart';
import 'package:epal/constants/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class profile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  profile({super.key});

  Future<http.Response> fetchAdmin(int id) {
    return http.get(Uri.parse(usedIPAddress + '/api/admin/$id'),
        headers: headers);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 1000.0),
        child: Container(
          height: 170,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Image.asset("assets/employee.png", width: 100, height: 100),
              SizedBox(width: 20),
              FutureBuilder<http.Response>(
                future: fetchAdmin(6),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final admin = jsonDecode(snapshot.data!.body);
                    return Padding(
                      padding: const EdgeInsets.only(top: 365.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: dark,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Nom/Prenom:  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${admin['Nom']} ${admin['Prenom']}',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: dark,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Role:   ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${admin['Role']}',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: dark,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Adresse:   ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${admin['Adresse']}',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: dark,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Telephone:   ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${admin['tel']}',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: dark,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Shift:   ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${admin['Shift']}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
