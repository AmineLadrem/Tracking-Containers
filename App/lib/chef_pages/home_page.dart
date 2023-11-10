import 'package:epal/constants/style.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:epal/icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChefParcHomePage extends StatefulWidget {
  const ChefParcHomePage({Key? key}) : super(key: key);

  @override
  State<ChefParcHomePage> createState() => _ChefParcHomePageState();
}

String prenom = '';
int nbrTotal = 0;
int nbrDispo = 0;
Future<dynamic> fetchUser(String email) async {
  var response =
      await http.get(Uri.parse(usedIPAddress + '/api/utilisateur/$email'));
  var chef = jsonDecode(response.body);
  prenom = chef['Prenom'].toString();
  var response2 = await http
      .get(Uri.parse(usedIPAddress + '/api/cdp/' + chef['ID'].toString()));
  var parc = jsonDecode(response2.body);
  return parc;
}

final user = FirebaseAuth.instance.currentUser!;
Future<List<dynamic>> fetchConteneurs() async {
  final parc = await fetchUser(user.email!);
  final apiUrl = usedIPAddress + '/api/parc/' + parc['NumParc'].toString();
  final response = await http.get(Uri.parse(apiUrl));

  final parcData = json.decode(response.body);
  nbrTotal = parcData['NbrTotal'];
  nbrDispo = parcData['NbrDispo'];
  return parcData;
}

class _ChefParcHomePageState extends State<ChefParcHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        height: 10,
                      ),
                      Text(
                        "Votre parc contient: ",
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
                        padding: const EdgeInsets.only(left: 110.0),
                        child: Row(
                          children: [
                            Icon(
                              MyFlutterApp.container,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Nombre de conteneurs:" +
                                  (nbrTotal - nbrDispo).toString(),
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
                        padding: const EdgeInsets.only(left: 110.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_offer,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Nombre de place disponible: $nbrDispo",
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
