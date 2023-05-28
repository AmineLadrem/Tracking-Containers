import 'package:epal/constants/style.dart';
import 'package:epal/helpers/ipAddresses.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class listedemande extends StatefulWidget {
  const listedemande({super.key});

  @override
  State<listedemande> createState() => _listedemandeState();
}

Future<dynamic> fetchUser(String email) async {
  var response =
      await http.get(Uri.parse(usedIPAddress + '/api/utilisateur/$email'));
  var chef = jsonDecode(response.body);

  return chef['ID'];
}

final user = FirebaseAuth.instance.currentUser!;
Future<List<dynamic>> fetchdemandes() async {
  final chef = await fetchUser(user.email!);
  print(chef);
  final apiUrl = usedIPAddress + '/api/demandes/chef/' + chef.toString();
  final response = await http.get(Uri.parse(apiUrl));
  print(response.body);
  final demandeList = <dynamic>[];
  final demandeData = json.decode(response.body);

  for (var demande in demandeData) {
    demandeList.add(demande);
  }

  return demandeList;
}

class _listedemandeState extends State<listedemande> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      body: Container(
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 20.0,
            width: 350,
          ),
          Image.asset("assets/epal.png", width: 164, height: 120),
          Container(
            height: 558,
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
                              color: Colors
                                  .black, // Set your desired border color here.
                              width: 1.0, // Set the border width as desired.
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: Image.asset("assets/arrow.png",
                                    width: 50, height: 50, color: light),
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Date:',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0,
                                            )),
                                        Text(
                                          _foundDemandes[index]['DateDemande']
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
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0,
                                            )),
                                        Text(
                                          _foundDemandes[index]['HeureDemande']
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Conducteur',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0,
                                            )),
                                        Text(
                                          _foundDemandes[index]['CDC_ID']
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
                                        Text('Parc Destination:',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0,
                                            )),
                                        Text(
                                          _foundDemandes[index]['ParcDest']
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text('Status:',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0,
                                            )),
                                        Text(
                                          _foundDemandes[index]['Status']
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
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
            ),
          ),
          SizedBox(
            height: 41,
          ),
          Container(
            height: 60,
            width: 600,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF80CFCC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 43,
                  width: 65,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 2),
                      Text(' Retourner',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(width: 6),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
            ]),
          )
        ])),
      ),
    );
  }
}
