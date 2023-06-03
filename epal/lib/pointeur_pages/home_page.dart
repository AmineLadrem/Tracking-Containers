import 'package:epal/constants/style.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:epal/icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PointeurHomePage extends StatefulWidget {
  const PointeurHomePage({Key? key}) : super(key: key);

  @override
  State<PointeurHomePage> createState() => _PointeurHomePageState();
}

String prenom = '';
int count = 0;
List<String> conteneurs = [];

var user = FirebaseAuth.instance.currentUser!;
Future<dynamic> fetchUser(String email) async {
  var res =
      await http.get(Uri.parse(usedIPAddress + '/api/utilisateur/$email'));
  var conducteur = jsonDecode(res.body);

  return conducteur;
}

Future<void> fetchConteneurs() async {
  final cond = await fetchUser(user.email!);
  final response =
      await http.get(Uri.parse(usedIPAddress + '/api/conteneur/nbr'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);

    count = jsonData['count'];
    conteneurs = List<String>.from(jsonData['conteneurIDs']);
    prenom = cond['Prenom'];
  } else {
    throw Exception('Failed to fetch demandes');
  }
}

class _PointeurHomePageState extends State<PointeurHomePage> {
  @override
  void initState() {
    super.initState();
    fetchConteneurs();
  }

  @override
  Widget build(BuildContext context) {
    fetchConteneurs();
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 150.0),
        child: Column(
          children: [
            FutureBuilder(
              future: fetchConteneurs(),
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
                        height: 20,
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.motion_photos_paused_sharp,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          Text(
                            " Nombre de conteneurs qui sont À bord",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                              color: dark,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            " et sans module de suivi : $count",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                              color: dark,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(
                              MyFlutterApp.container,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Les conteneurs:",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                              color: dark,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$conteneurs",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          color: dark,
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
