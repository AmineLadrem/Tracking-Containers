import 'package:epal/constants/style.dart';
import 'package:epal/icons.dart';
import 'package:epal/widgets/location.dart';
import 'package:epal/widgets/realtime_location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class containers extends StatefulWidget {
  const containers({super.key});

  @override
  State<containers> createState() => _containersState();
}

class _containersState extends State<containers> {
  final _searchController = TextEditingController();
  dynamic selectedStatusItem;
  dynamic selectedTypeItem;
  Future<List<dynamic>> fetchConteneurs() async {
    final apiUrl = 'http://127.0.0.1:8000/api/conteneur';
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
    var response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/modulesuivis/' + id.toString()));

    var container = await http.get(Uri.parse(
        'http://127.0.0.1:8000/api/conteneur/modulesuivi/' + id.toString()));

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
    TextEditingController contIDController = TextEditingController();
    TextEditingController contTypeController = TextEditingController();
    TextEditingController contPoidsController = TextEditingController();

    TextEditingController numLivraisonController = TextEditingController();
    TextEditingController numEmbarquementController = TextEditingController();
    TextEditingController numDebarquementController = TextEditingController();
    TextEditingController numVisiteController = TextEditingController();
    TextEditingController numParcController = TextEditingController();
    addContainer() async {
      final String apiUrl = 'http://127.0.0.1:8000/api/conteneur?Cont_ID=' +
          contIDController.text +
          '&Cont_Type=' +
          contTypeController.text +
          '&Cont_Poids=' +
          contPoidsController.text +
          '&Cont_Status=In-Board' +
          '&ModNum=0' +
          '&NumLivraison=' +
          numLivraisonController.text +
          '&NumEmbarquement=' +
          numEmbarquementController.text +
          '&NumDebarquement=' +
          numDebarquementController.text +
          '&NumVisite=' +
          numVisiteController.text +
          '&NumParc=' +
          numParcController.text +
          '&Admin_ID=' +
          1.toString();
      print(apiUrl);

      final response = await http.post(Uri.parse(apiUrl));

      //pop notification
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Conteneur ajouté avec succès'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'ajout du Conteneur'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Container(
        height: 1000,
        width: 300,
        child: Row(children: [
          Expanded(
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
                      labelText: 'Search',
                      labelStyle: TextStyle(color: dark),
                      prefixIcon: Icon(Icons.search, color: light),
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
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: fetchConteneurs(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final _foundConteneurs = snapshot.data!;
                        return ListView.builder(
                          itemCount: _foundConteneurs.length,
                          itemBuilder: (context, index) => Card(
                            key: ValueKey(_foundConteneurs[index]['Cont_ID']),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: back,
                                  borderRadius: BorderRadius.circular(10.0),
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
                                            TextButton(
                                              onPressed: () {
                                                getPosition(int.parse(
                                                    _foundConteneurs[index]
                                                        ['ModNum']));
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
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF80CFCC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Center(
                            child: Text(
                              'Ajouter un Conteneur',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                color: Colors.white,
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
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
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
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
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
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
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
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: numParcController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: back,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: 'Numero de Parc',
                        labelStyle: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        hintText: 'Entrez le Numero de Parc',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon:
                            Icon(Icons.local_parking, color: Colors.blue),
                        suffixIcon: IconButton(
                          onPressed: () {
                            numParcController.clear();
                          },
                          icon: Icon(Icons.clear, color: dark),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 45,
                      width: 300,
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
