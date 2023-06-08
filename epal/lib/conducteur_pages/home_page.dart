import 'package:epal/constants/style.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConducteurHomePage extends StatefulWidget {
  const ConducteurHomePage({Key? key}) : super(key: key);

  @override
  State<ConducteurHomePage> createState() => _ConducteurHomePageState();
}

String prenom = '';
int accepteCount = 0;
int enCoursCount = 0;
int termineeCount = 0;
var user = FirebaseAuth.instance.currentUser!;
Future<dynamic> fetchUser(String email) async {
  var res =
      await http.get(Uri.parse(usedIPAddress + '/api/utilisateur/$email'));
  var conducteur = jsonDecode(res.body);

  return conducteur;
}

Future<void> fetchDemandes() async {
  final cond = await fetchUser(user.email!);
  final response = await http.get(Uri.parse(
      usedIPAddress + '/api/demandes/conducteur/nbr/' + cond['ID'].toString()));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);

    accepteCount = jsonData['accepteCount'];
    enCoursCount = jsonData['enCoursCount'];
    termineeCount = jsonData['termineeCount'];
    prenom = cond['Prenom'];
  } else {
    throw Exception('Failed to fetch demandes');
  }
}

class _ConducteurHomePageState extends State<ConducteurHomePage> {
  @override
  void initState() {
    super.initState();
    fetchDemandes();
  }

  @override
  Widget build(BuildContext context) {
    fetchDemandes();
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 150.0),
        child: Column(
          children: [
            FutureBuilder(
              future: fetchDemandes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Bienvenue $prenom,",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Vous avez des demandes:",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 160.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Acceptée: $accepteCount",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                color: dark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 160.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timelapse,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "En Cours: $enCoursCount",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                color: dark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 160.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Terminée: $termineeCount",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                color: dark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 90.0),
                    child: CircularProgressIndicator(
                      color: Color(0xFF80CFCC),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
