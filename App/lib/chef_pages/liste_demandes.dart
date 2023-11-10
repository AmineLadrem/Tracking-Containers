import 'package:epal/constants/style.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

Future<dynamic> annulerDemande(int num) async {
  await http.delete(Uri.parse(usedIPAddress + '/api/demande/annuler/$num'));
  Fluttertoast.showToast(
      msg: "Demande annulée avec succès",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

final user = FirebaseAuth.instance.currentUser!;
Future<List<dynamic>> fetchdemandes() async {
  final chef = await fetchUser(user.email!);

  final apiUrl = usedIPAddress + '/api/demandes/chef/' + chef.toString();
  final response = await http.get(Uri.parse(apiUrl));

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
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(
                                  0xFF80CFCC), // Set your desired border color here.
                              width: 2.0, // Set the border width as desired.
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Image.asset("assets/arrow.png",
                                        width: 50, height: 50, color: light),
                                  ),
                                  SizedBox(
                                    width: 3.0,
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
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
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
                                        SizedBox(
                                          height: 5.0,
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
                                    width: 5.0,
                                  ),
                                  Container(
                                    width: 165,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Conteneur :',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0,
                                                )),
                                            Text(
                                              _foundDemandes[index]['Cont_ID']
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 13.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
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
                                    width: 8.0,
                                  ),
                                  Container(
                                    width: 70,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                              SizedBox(
                                height: 5.0,
                              ),
                              Visibility(
                                visible: (_foundDemandes[index]['Status'] ==
                                    'En Attente'),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 157.0, right: 157.0, bottom: 7.0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        annulerDemande(
                                            _foundDemandes[index]['DemNum']);
                                        setState(() {});
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Annuler'),
                                        ],
                                      )),
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
                    children: [
                      SizedBox(height: 10),
                      Icon(Icons.arrow_back),
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