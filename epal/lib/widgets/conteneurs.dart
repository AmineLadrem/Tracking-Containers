import 'package:epal/WebPages/ipAddress.dart';
import 'package:epal/constants/style.dart';
import 'package:epal/icons.dart';

import 'package:epal/widgets/realtime_location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController contIDController = TextEditingController();
TextEditingController contTypeController = TextEditingController();
TextEditingController contPoidsController = TextEditingController();
TextEditingController numLivraisonController = TextEditingController();
TextEditingController numEmbarquementController = TextEditingController();
TextEditingController numDebarquementController = TextEditingController();
TextEditingController numVisiteController = TextEditingController();

bool isVisible1 = false;
String dateAndTime1 = '';
bool isVisible2 = false;
String dateAndTime2 = '';
bool isVisible3 = false;
String dateAndTime3 = '';
bool isVisible4 = false;
String dateAndTime4 = '';

bool isVisible5 = false;
String typeCont = '';

class containers extends StatefulWidget {
  const containers({super.key});

  @override
  State<containers> createState() => _containersState();
}

class _containersState extends State<containers> {
  void contType(String value) {
    setState(() {
      if (contTypeController.text != '20p' ||
          contTypeController.text != '40p') {
        isVisible5 = true;

        typeCont = 'Veuillez entrez un type valide (20p-40p)';
      } else {
        isVisible5 = false;
      }
    });
  }

  Future<void> _getEmbarquement(String value) async {
    var apiUrl = usedIPAddress + '/api/embarquement/$value';
    var response = await http.get(Uri.parse(apiUrl), headers: headers);
    var deb = json.decode(response.body);
    setState(() {
      if (numEmbarquementController.text.isNotEmpty) {
        isVisible4 = true;

        dateAndTime4 =
            'Date: ${deb['DateEmbarquement']} Heure: ${deb['HeureEmbarquement']}';
      } else {
        isVisible4 = false;
      }
    });
  }

  Future<void> _getDebarquement(String value) async {
    var apiUrl = usedIPAddress + '/api/debarquement/$value';
    var response = await http.get(Uri.parse(apiUrl), headers: headers);
    var deb = json.decode(response.body);
    setState(() {
      if (numDebarquementController.text.isNotEmpty) {
        isVisible1 = true;

        dateAndTime1 =
            'Date: ${deb['DateDebarquement']} Heure: ${deb['HeureDebarquement']}';
      } else {
        isVisible1 = false;
      }
    });
  }

  Future<void> _getVisite(String value) async {
    var apiUrl = usedIPAddress + '/api/visite/$value';
    var response = await http.get(Uri.parse(apiUrl), headers: headers);
    var deb = json.decode(response.body);
    setState(() {
      if (numVisiteController.text.isNotEmpty) {
        isVisible2 = true;

        dateAndTime2 =
            'Date: ${deb['DateVisite']} Heure: ${deb['HeureVisite']}';
      } else {
        isVisible2 = false;
      }
    });
  }

  Future<void> _getLivraison(String value) async {
    var apiUrl = usedIPAddress + '/api/livraison/$value';
    var response = await http.get(Uri.parse(apiUrl), headers: headers);
    var deb = json.decode(response.body);
    setState(() {
      if (numLivraisonController.text.isNotEmpty) {
        isVisible3 = true;

        dateAndTime3 =
            'Date: ${deb['DateLivraison']} Heure: ${deb['HeureLivraison']}';
      } else {
        isVisible3 = false;
      }
    });
  }

  final _searchController = TextEditingController();
  dynamic selectedStatusItem;
  dynamic selectedTypeItem;
  Future<List<dynamic>> fetchConteneurs() async {
    final apiUrl = usedIPAddress + '/api/conteneur';
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
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
    var response = await http.get(
        Uri.parse(usedIPAddress + '/api/modulesuivis/' + id.toString()),
        headers: headers);

    var container = await http.get(
        Uri.parse(
            usedIPAddress + '/api/conteneur/modulesuivi/' + id.toString()),
        headers: headers);

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
    addContainer() async {
      if (contIDController.text.isEmpty ||
          contTypeController.text.isEmpty ||
          contPoidsController.text.isEmpty ||
          numLivraisonController.text.isEmpty ||
          numEmbarquementController.text.isEmpty ||
          numDebarquementController.text.isEmpty ||
          numVisiteController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Veuillez remplir tous les champs'),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }

      final String apiUrl = usedIPAddress +
          '/api/conteneur?Cont_ID=' +
          contIDController.text +
          '&Cont_Type=' +
          contTypeController.text +
          '&Cont_Poids=' +
          contPoidsController.text +
          '&Cont_Status=À bord' +
          '&ModNum=0' +
          '&NumLivraison=' +
          numLivraisonController.text +
          '&NumEmbarquement=' +
          numEmbarquementController.text +
          '&NumDebarquement=' +
          numDebarquementController.text +
          '&NumVisite=' +
          numVisiteController.text +
          '&NumParc=0' +
          '&Admin_ID=' +
          1.toString();
      print(apiUrl);
      final response = await http.post(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        sendAndroidNotification(contIDController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Conteneur ajouté avec succès , Une demande de liaison a été envoyée au pointeurs '),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {});
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'ajout du Conteneur'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

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
        height: 1000,
        width: 300,
        child: Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        // Call setState to rebuild the widget when the text changes
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Rechercher par l\'ID du conteneur',
                        labelText: 'Rechercher',
                        labelStyle: TextStyle(color: dark),
                        prefixIcon: Icon(Icons.search, color: light),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  Expanded(
                    child: FutureBuilder<List<dynamic>>(
                      future: fetchConteneurs(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final _foundConteneurs = snapshot.data!;
                          return ListView.builder(
                            itemCount: _foundConteneurs.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: Container(
                                key: ValueKey(
                                    _foundConteneurs[index]['Cont_ID']),
                                decoration: BoxDecoration(
                                  color: back,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Color(0xFF80CFCC),
                                    width: 2.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Image.asset("assets/container.png",
                                          width: 100, height: 100),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16.0,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Conteneur-ID:  ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      style: TextStyle(
                                                          color: dark),
                                                      text: _foundConteneurs[
                                                          index]['Cont_ID'],
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
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      style: TextStyle(
                                                          color: dark),
                                                      text: _foundConteneurs[
                                                          index]['Cont_Status'],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: [
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
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    style:
                                                        TextStyle(color: dark),
                                                    text:
                                                        _foundConteneurs[index]
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
                                                    text: 'Cont-Type:  ',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    style:
                                                        TextStyle(color: dark),
                                                    text:
                                                        _foundConteneurs[index]
                                                            ['Cont_Type'],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text('Details'),
                                                      content: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Conteneur-ID:  ',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  style: TextStyle(
                                                                      color:
                                                                          dark),
                                                                  text: _foundConteneurs[
                                                                          index]
                                                                      [
                                                                      'Cont_ID'],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Status:  ',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  style: TextStyle(
                                                                      color:
                                                                          dark),
                                                                  text: _foundConteneurs[
                                                                          index]
                                                                      [
                                                                      'Cont_Status'],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Cont-Type:  ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  style: TextStyle(
                                                                      color:
                                                                          dark),
                                                                  text: _foundConteneurs[
                                                                          index]
                                                                      [
                                                                      'Cont_Type'],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Tracker-ID:  ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  style: TextStyle(
                                                                      color:
                                                                          dark),
                                                                  text: _foundConteneurs[
                                                                              index]
                                                                          [
                                                                          'ModNum']
                                                                      .toString(),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Numero de debarquement:  ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  style: TextStyle(
                                                                      color:
                                                                          dark),
                                                                  text: _foundConteneurs[
                                                                              index]
                                                                          [
                                                                          'NumDebarquement']
                                                                      .toString(),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Numero d\'embarquement:  ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  style: TextStyle(
                                                                      color:
                                                                          dark),
                                                                  text: _foundConteneurs[
                                                                              index]
                                                                          [
                                                                          'NumEmbarquement']
                                                                      .toString(),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Numero de visite:  ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  style: TextStyle(
                                                                      color:
                                                                          dark),
                                                                  text: _foundConteneurs[
                                                                              index]
                                                                          [
                                                                          'NumVisite']
                                                                      .toString(),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Numero de livraison:  ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  style: TextStyle(
                                                                      color:
                                                                          dark),
                                                                  text: _foundConteneurs[
                                                                              index]
                                                                          [
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Fermer'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              onHover: (event) {},
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Details    ',
                                                    style: TextStyle(
                                                      color: dark,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Icon(Icons.menu,
                                                      color: Colors.black)
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: (_foundConteneurs[index]
                                                      ['ModNum'] !=
                                                  '0'),
                                              child: TextButton(
                                                onPressed: () {
                                                  getPosition(
                                                      _foundConteneurs[index]
                                                          ['ModNum']);
                                                },
                                                onHover: (event) {},
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Localiser',
                                                      style: TextStyle(
                                                        color: dark,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Icon(Icons.location_on,
                                                        color: Colors.black)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
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
            ),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 9.0, left: 60.0, right: 60.0, bottom: 9.0),
                child: Column(
                  children: [
                    SizedBox(height: 127),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Center(
                            child: Text(
                              'Ajouter un Conteneur',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                color: dark,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: contIDController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Conteneur-ID',
                        labelStyle: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Entrez votre Conteneur-ID',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon:
                            Icon(Icons.confirmation_number, color: dark),
                        suffixIcon: IconButton(
                          onPressed: () {
                            contIDController.clear();
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          if (contTypeController.text.isEmpty) {
                            setState(() {
                              isVisible5 = false;
                            });
                          }
                          contType(value);
                        });
                      },
                      controller: contTypeController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Type',
                        labelStyle: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Entrez le type du conteneur(20p-40p)',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(MyFlutterApp.container,
                            color: Colors.orange[500]),
                        suffixIcon: IconButton(
                          onPressed: () {
                            contTypeController.clear();
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    Visibility(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                isVisible5 ? typeCont : '',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  color: dark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                      visible: isVisible5,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: contPoidsController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Poids (Kg)',
                        labelStyle: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Entrez le poids du conteneur',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon:
                            Icon(Icons.fitness_center, color: Colors.blue[500]),
                        suffixIcon: IconButton(
                          onPressed: () {
                            contPoidsController.clear();
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          if (numDebarquementController.text.isEmpty) {
                            setState(() {
                              isVisible1 = false;
                            });
                          }
                          _getDebarquement(value);
                        });
                      },
                      controller: numDebarquementController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Numero de debarquement',
                        labelStyle: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Entrez votre Numero de debarquement',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon:
                            Icon(Icons.call_missed_outgoing, color: Colors.red),
                        suffixIcon: IconButton(
                          onPressed: () {
                            numDebarquementController.clear();
                            setState(() {
                              isVisible1 = false;
                            });
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    Visibility(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                isVisible1 ? dateAndTime1 : '',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  color: dark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                      visible: isVisible1,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          if (numEmbarquementController.text.isEmpty) {
                            setState(() {
                              isVisible4 = false;
                            });
                          }
                          _getEmbarquement(value);
                        });
                      },
                      controller: numEmbarquementController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Numero d\'embarquement',
                        labelStyle: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Entrez le Numero d\'embarquement',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon:
                            Icon(Icons.call_missed, color: Colors.green),
                        suffixIcon: IconButton(
                          onPressed: () {
                            numEmbarquementController.clear();
                            isVisible4 = false;
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    Visibility(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                isVisible4 ? dateAndTime4 : '',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  color: dark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                      visible: isVisible4,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          if (numLivraisonController.text.isEmpty) {
                            setState(() {
                              isVisible3 = false;
                            });
                          }
                          _getLivraison(value);
                        });
                      },
                      controller: numLivraisonController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Numero de livraison',
                        labelStyle: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Entrez le Numero de livraison',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(Icons.local_shipping,
                            color: Color(0xFFFF9800)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            numLivraisonController.clear();
                            isVisible3 = false;
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    Visibility(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                isVisible3 ? dateAndTime3 : '',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  color: dark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                      visible: isVisible3,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          if (numVisiteController.text.isEmpty) {
                            setState(() {
                              isVisible2 = false;
                            });
                          }
                          _getVisite(value);
                        });
                      },
                      controller: numVisiteController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Numero de visite',
                        labelStyle: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Entrez le Numero de visite',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(Icons.event, color: dark),
                        suffixIcon: IconButton(
                          onPressed: () {
                            numVisiteController.clear();
                            isVisible2 = false;
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    Visibility(
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                isVisible2 ? dateAndTime2 : '',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  color: dark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                      visible: isVisible2,
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: addContainer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80CFCC),
                        ),
                        child: Text('Ajouter',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}

void sendAndroidNotification(dynamic conteneur) async {
  Map<String, dynamic> jsonBody = {
    "registration_ids": [
      "dh6aLDYQTmCFPFvFOcrai4:APA91bEa-2yPK6BH3TntmCK-4ULevxw9XgxZktjQMi22-Sun0Y9oVYj7LnIMdZYvI0zHcQqeLwO9qzvBp6Niv-QpalIXJFRTvtU_qKNLJh75w4_ReggzNA1_sp5okV7kNLVbGqmLXUwq",
      "dET9T0zpTZ-jdn_MGaFgfC:APA91bFr_2-cIFwoySLjSUSjT183FIdD_i32h6D_ex7gNI0fCA_zVBrGV9tEe9Y4X29v4k2p1N2GwjGfQVaN-wMijTCnOepfpUk8JDHMn0Q2fhJP0QxyjKM91sxe4lSGHhCz2hPLwUjL"
    ],
    "notification": {
      "title": "[EPAL] Conteneur ajouté",
      "body": " Un nouveau conteneur [$conteneur] a été ajouté",
      "content_available": true,
      "android": {
        "style": "bigtext",
        "priority": "high",
        "bigTextStyle": {
          "summaryText": "EPAL",
          "bigText": "Un nouveau conteneur [$conteneur] a été ajouté"
        }
      }
    },
  };

  String serverKey =
      "AAAAN-J_R3k:APA91bEzx_24yCRNQau9alc5v4Y7mhmO9lxQOn7G143Rvfd-rC4LoDdfDBpR9HkCfgjd53IadcrMaWPjQHCo-GrPG5hZEQKiebcoO4BfkFDqV3_Thzp-PfSBYZFuyVNzAiD3rcb2r8tB";
  String fcmUrl = "https://fcm.googleapis.com/fcm/send";

  http.Response response = await http.post(
    Uri.parse(fcmUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'key=$serverKey',
    },
    body: jsonEncode(jsonBody),
  );

  // Handle the response
  if (response.statusCode == 200) {
    // Notification sent successfully
    print("Notification sent successfully");
  } else {
    // Error sending notification
    print("Error sending notification. Status code: ${response.statusCode}");
  }
}
