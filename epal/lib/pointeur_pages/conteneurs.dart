import 'dart:convert';
import 'package:epal/constants/style.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:epal/pages/location.dart';
import 'package:epal/pages/realtime_location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Conteneurs extends StatefulWidget {
  const Conteneurs({super.key});

  @override
  State<Conteneurs> createState() => _ConteneursState();
}

class _ConteneursState extends State<Conteneurs> {
  final _searchController = TextEditingController();
  Future<List<dynamic>> fetchConteneurs() async {
    final apiUrl = usedIPAddress + '/api/conteneur';
    final response = await http.get(Uri.parse(apiUrl));
    final conteneurList = <dynamic>[];
    final conteneurData = json.decode(response.body);

    for (var conteneur in conteneurData) {
      conteneurList.add(conteneur);
    }
    if (_searchController.text.isNotEmpty) {
      conteneurList.retainWhere((conteneur) => conteneur['Cont_ID']
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()));
    }

    return conteneurList;
  }

  Future<void> getPosition(int id) async {
    var response = await http
        .get(Uri.parse(usedIPAddress + '/api/modulesuivis/' + id.toString()));
    var container = await http.get(Uri.parse(
        usedIPAddress + '/api/conteneur/modulesuivi/' + id.toString()));

    // Parse the JSON response
    var data = json.decode(response.body);
    var data2 = json.decode(container.body);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RealTime(
          Cont_ID: data2['Cont_ID'].toString(),
          ModNum: data['ModNum'],
        ),
      ),
    );
    // Use the position values as needed in your code
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: Column(
        children: [
          Container(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // Call setState to rebuild the widget when the text changes
                setState(() {});
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                hintText: "Rechercher un conteneur",
                prefixIcon: Icon(
                  Icons.search,
                  color: dark,
                ),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: fetchConteneurs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final _foundConteneurs = snapshot.data!;
                  return ListView.builder(
                    itemCount: _foundConteneurs.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(2.0),
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
                              child: Image.asset("assets/container.png",
                                  width: 50, height: 50),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Conteneur-ID:',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                          )),
                                      Text(
                                        _foundConteneurs[index]['Cont_ID'],
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Status:',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                          )),
                                      Text(
                                        _foundConteneurs[index]['Cont_Status'],
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Parc:',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                          )),
                                      Text(
                                        _foundConteneurs[index]['NumParc']
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
                            Expanded(
                              child: Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Details'),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Conteneur-ID:  ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          style: TextStyle(
                                                              color: dark),
                                                          text:
                                                              _foundConteneurs[
                                                                      index]
                                                                  ['Cont_ID'],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: 'Cont-Type:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          style: TextStyle(
                                                              color: dark),
                                                          text:
                                                              _foundConteneurs[
                                                                      index]
                                                                  ['Cont_Type'],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: 'Cont-Poids:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          style: TextStyle(
                                                              color: dark),
                                                          text: _foundConteneurs[
                                                                          index]
                                                                      [
                                                                      'Cont_Poids']
                                                                  .toString() +
                                                              ' KG',
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: 'Status:  ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          style: TextStyle(
                                                              color: dark),
                                                          text: _foundConteneurs[
                                                                  index]
                                                              ['Cont_Status'],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: 'Tracker-ID:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          style: TextStyle(
                                                              color: dark),
                                                          text:
                                                              _foundConteneurs[
                                                                          index]
                                                                      ['ModNum']
                                                                  .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Numero de debarquement:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          style: TextStyle(
                                                              color: dark),
                                                          text: _foundConteneurs[
                                                                      index][
                                                                  'NumDebarquement']
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Numero d\'embarquement:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          style: TextStyle(
                                                              color: dark),
                                                          text: _foundConteneurs[
                                                                      index][
                                                                  'NumEmbarquement']
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Numero de visite:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          style: TextStyle(
                                                              color: dark),
                                                          text: _foundConteneurs[
                                                                      index]
                                                                  ['NumVisite']
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Numero de livraison:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          style: TextStyle(
                                                              color: dark),
                                                          text: _foundConteneurs[
                                                                      index][
                                                                  'NumLivraison']
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Fermer'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      onHover: (event) {},
                                      child: Icon(Icons.menu,
                                          color: Colors.black)),
                                  TextButton(
                                      onPressed: () {
                                        getPosition(int.parse(
                                            _foundConteneurs[index]['ModNum']));
                                      },
                                      onHover: (event) {},
                                      child: Icon(Icons.location_on,
                                          color: Colors.black))
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
            ),
          ),
        ],
      ),
    );
  }
}
