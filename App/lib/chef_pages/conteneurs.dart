import 'dart:convert';
import 'package:epal/constants/style.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:epal/pages/realtime_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ConteneursChef extends StatefulWidget {
  const ConteneursChef({super.key});

  @override
  State<ConteneursChef> createState() => _ConteneursChefState();
}

Future<dynamic> fetchUser(String email) async {
  var response =
      await http.get(Uri.parse(usedIPAddress + '/api/utilisateur/$email'));
  var chef = jsonDecode(response.body);
  var response2 = await http
      .get(Uri.parse(usedIPAddress + '/api/cdp/' + chef['ID'].toString()));
  var parc = jsonDecode(response2.body);
  return parc;
}

final user = FirebaseAuth.instance.currentUser!;

class _ConteneursChefState extends State<ConteneursChef> {
  final _searchController = TextEditingController();
  dynamic selectedTypeItem;
  Future<List<dynamic>> fetchConteneurs() async {
    final parc = await fetchUser(user.email!);
    final apiUrl =
        usedIPAddress + '/api/conteneur/numparc/' + parc['NumParc'].toString();
    final response = await http.get(Uri.parse(apiUrl));
    print(response.body);
    final conteneurList = <dynamic>[];
    final conteneurData = json.decode(response.body);

    for (var conteneur in conteneurData) {
      conteneurList.add(conteneur);
    }

    if (_searchController.text.isNotEmpty) {
      conteneurList.retainWhere((conteneur) {
        final contIDMatches = conteneur['Cont_ID']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
        final contTypeMatches = conteneur['Cont_Type']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
        return contIDMatches || contTypeMatches;
      });
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
          Cont_ID: data2['Cont_ID'],
          ModNum: data['ModNum'],
        ),
      ),
    );
    // Use the position values as needed in your code
  }

  @override
  Widget build(BuildContext context) {
    void fillTextField() {
      setState(() {
        _searchController.text = '20p'; // Set the desired value here
      });
    }

    void fillTextField2() {
      setState(() {
        _searchController.text = '40p'; // Set the desired value here
      });
    }

    return Container(
      width: 350,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF80CFCC), // Set your desired border color here.
                width: 2.0, // Set the border width as desired.
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
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
                suffixIcon: IconButton(
                  onPressed: () => _searchController.clear(),
                  icon: Icon(Icons.clear, color: Colors.red),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 45,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: fillTextField,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF80CFCC),
                  ),
                  child: Text('20p',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Text(
                'Ou par la categorie',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  color: dark,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 45,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: fillTextField2,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF80CFCC),
                  ),
                  child: Text('40p',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
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
                      padding: const EdgeInsets.only(
                          right: 2.0, left: 2.0, top: 2.0, bottom: 30.0),
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
                                            color: dark,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                          )),
                                      Text(
                                        _foundConteneurs[index]['Cont_ID'],
                                        style: TextStyle(
                                          color: dark,
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
                                            color: dark,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                          )),
                                      Text(
                                        _foundConteneurs[index]['Cont_Status'],
                                        style: TextStyle(
                                          color: dark,
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
                                            color: dark,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                          )),
                                      Text(
                                        _foundConteneurs[index]['NumParc']
                                            .toString(),
                                        style: TextStyle(
                                          color: dark,
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
                                          color: Color(0xFF80CFCC))),
                                  TextButton(
                                      onPressed: () {
                                        getPosition(
                                            _foundConteneurs[index]['ModNum']);
                                      },
                                      onHover: (event) {},
                                      child: Icon(Icons.location_on,
                                          color: Color(0xFF80CFCC)))
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
