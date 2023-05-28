import 'dart:async';
import 'dart:convert';

import 'package:epal/conducteur_pages/cond_demandes.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:epal/constants/style.dart';
import 'package:flutter/material.dart';

class ListeDemandesCond extends StatefulWidget {
  static const String routeName = '/liste_demandes_cond';
  const ListeDemandesCond({super.key});

  @override
  State<ListeDemandesCond> createState() => _ListeDemandesCondState();
}

class _ListeDemandesCondState extends State<ListeDemandesCond> {
  Future<dynamic> fetchUser(String email) async {
    var response =
        await http.get(Uri.parse(usedIPAddress + '/api/utilisateur/$email'));
    var conducteur = jsonDecode(response.body);

    return conducteur['ID'];
  }

  final user = FirebaseAuth.instance.currentUser!;
  Future<dynamic> acceptDem(int id) async {
    var conducteur = await fetchUser(user.email!);
    var response = await http.put(Uri.parse(
        usedIPAddress + '/api/demandes/conducteur/accepte/$id/$conducteur'));
  }

  Future<List<dynamic>> fetchdemandes() async {
    //timer with seconds

    final apiUrl = usedIPAddress + '/api/demandes/0';
    final response = await http.get(Uri.parse(apiUrl));
    final demandeList = <dynamic>[];
    final demandeData = json.decode(response.body);

    for (var demande in demandeData) {
      print(demande);
      demandeList.add(demande);
    }

    return demandeList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 80, left: 10.0, right: 10.0, bottom: 10.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: Colors.white,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Image.asset(
                            "assets/deplacement.png",
                            width: 80,
                            height: 80,
                            color: Color(0xFF80CFCC),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 250,
                      child: Container(
                        child: Expanded(
                            child: FutureBuilder(
                          future: fetchdemandes(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final _foundDemandes = snapshot.data!;
                              return ListView.builder(
                                itemCount: _foundDemandes.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(
                                            0xFF80CFCC), // Set your desired border color here.
                                        width:
                                            2.0, // Set the border width as desired.
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                  "assets/arrow.png",
                                                  width: 50,
                                                  height: 50,
                                                  color: light),
                                            ),
                                            SizedBox(
                                              width: 17,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('Date:',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13.0,
                                                          )),
                                                      Text(
                                                        _foundDemandes[index]
                                                                ['DateDemande']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 13.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('Heure:',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13.0,
                                                          )),
                                                      Text(
                                                        _foundDemandes[index]
                                                                ['HeureDemande']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 13.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 17,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('Parc Destination:',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13.0,
                                                          )),
                                                      Text(
                                                        _foundDemandes[index]
                                                                ['ParcDest']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 13.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('Parc Départ:',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13.0,
                                                          )),
                                                      Text(
                                                        _foundDemandes[index]
                                                                ['ParcDepart']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 13.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 17,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text('Status:',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13.0,
                                                          )),
                                                      Text(
                                                        _foundDemandes[index]
                                                                ['Status']
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 13.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 146.0, left: 146.0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                acceptDem(_foundDemandes[index]
                                                    ['DemNum']);
                                                setState(() {});
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DemCond()));
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xFF80CFCC)),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),
                                                  Text('Accepter'),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(top: 70.0),
                                child: Column(
                                  children: [
                                    CircularProgressIndicator(
                                      color: Color(0xFF80CFCC),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Pas de demandes pour le moment',
                                      style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 33.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DemCond()));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF80CFCC)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.playlist_add_check,
                        color: Colors.white,
                      ),
                      Text(
                        '  Voir ma liste des demandes ',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
