import 'package:epal/constants/style.dart';
import 'package:epal/widgets/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class containers extends StatefulWidget {
  const containers({super.key});

  @override
  State<containers> createState() => _containersState();
}

class _containersState extends State<containers> {
  Future<List<dynamic>> fetchConteneurs() async {
    final apiUrl = 'http://127.0.0.1:8000/api/conteneur';
    final response = await http.get(Uri.parse(apiUrl));
    final conteneurList = <dynamic>[];
    final conteneurData = json.decode(response.body);

    for (var conteneur in conteneurData) {
      conteneurList.add(conteneur);
    }
    print(conteneurList);
    return conteneurList;
  }

  Future<List<dynamic>> fetchModule(int id) async {
    final apiUrl = 'http://127.0.0.1:8000/api/modulesuivis/' + id.toString();
    final response = await http.get(Uri.parse(apiUrl));
    final moduleList = <dynamic>[];
    final moduleData = json.decode(response.body);

    for (var module in moduleData) {
      moduleList.add(module);
    }
    print(moduleList);
    return moduleList;
  }

  Future<List<dynamic>> _foundConteneurs = Future.value([]);

  @override
  void initState() {
    _foundConteneurs = fetchConteneurs();
    super.initState();
  }

  void _runFilter(String keyword) {
    Future<List<dynamic>> results = Future.value([]);
    if (keyword.isEmpty) {
      results = fetchConteneurs();
    } else {
      results = _foundConteneurs.then((moduleList) {
        return moduleList
            .where((module) => module['ModNum'].contains(keyword))
            .toList();
      });
    }
    setState(() {
      _foundConteneurs = results;
    });
  }

  Widget build(BuildContext context) {
    var module;
    TextEditingController contIDController = TextEditingController();
    TextEditingController contTypeController = TextEditingController();
    TextEditingController contPoidsController = TextEditingController();
    TextEditingController contStatusController = TextEditingController();
    TextEditingController modNumController = TextEditingController();
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
          '&Cont_Status=' +
          contStatusController.text +
          '&ModNum=' +
          modNumController.text +
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
          6.toString();
      print(apiUrl);

      final response = await http.post(Uri.parse(apiUrl));

      //pop notification
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Module ajouté avec succès'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'ajout du module'),
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
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 400,
                    child: TextField(
                      onChanged: (value) => _runFilter(value),
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
                                        child: Image.asset(
                                            "assets/container.png",
                                            width: 100,
                                            height: 100),
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
                                                                index]
                                                            ['Cont_Status'],
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
                                                      style: TextStyle(
                                                          color: dark),
                                                      text: _foundConteneurs[
                                                              index]['ModNum']
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
                                                      style: TextStyle(
                                                          color: dark),
                                                      text: _foundConteneurs[
                                                          index]['Cont_Type'],
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
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      16.0,
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
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      16.0,
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
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      16.0,
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
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      16.0,
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
                                                                    text: _foundConteneurs[index]
                                                                            [
                                                                            'ModNum']
                                                                        .toString(),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      16.0,
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
                                                                    text: _foundConteneurs[index]
                                                                            [
                                                                            'NumDebarquement']
                                                                        .toString(),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      16.0,
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
                                                                    text: _foundConteneurs[index]
                                                                            [
                                                                            'NumEmbarquement']
                                                                        .toString(),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      16.0,
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
                                                                    text: _foundConteneurs[index]
                                                                            [
                                                                            'NumVisite']
                                                                        .toString(),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      16.0,
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
                                                                    text: _foundConteneurs[index]
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
                                                            child:
                                                                Text('Fermer'),
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
                                                onPressed: () {},
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
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                contIDController.clear();
                              },
                              icon: Icon(Icons.clear)),
                          labelText: 'Conteneur-ID',
                          hintText: 'Conteneur-ID'),
                      controller: contIDController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                contStatusController.clear();
                              },
                              icon: Icon(Icons.clear)),
                          labelText: 'Status',
                          hintText: 'Status'),
                      controller: contStatusController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                contTypeController.clear();
                              },
                              icon: Icon(Icons.clear)),
                          labelText: 'Type de Conteneur',
                          hintText: 'Type de Conteneur'),
                      controller: contTypeController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                contPoidsController.clear();
                              },
                              icon: Icon(Icons.clear)),
                          labelText: 'Poids (Kg)',
                          hintText: 'Poids (Kg)'),
                      controller: contPoidsController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                modNumController.clear();
                              },
                              icon: Icon(Icons.clear)),
                          labelText: 'Numero de Module de suivi',
                          hintText: 'Numero de Module de suivi'),
                      controller: modNumController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                numDebarquementController.clear();
                              },
                              icon: Icon(Icons.clear)),
                          labelText: 'Numero de debarquement',
                          hintText: 'Numero de debarquement'),
                      controller: numDebarquementController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                numEmbarquementController.clear();
                              },
                              icon: Icon(Icons.clear)),
                          labelText: 'Numero d\'embarquement',
                          hintText: 'Numero d\'embarquement'),
                      controller: numEmbarquementController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                numLivraisonController.clear();
                              },
                              icon: Icon(Icons.clear)),
                          labelText: 'Numero de livraison',
                          hintText: 'Numero de livraison'),
                      controller: numLivraisonController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                numVisiteController.clear();
                              },
                              icon: Icon(Icons.clear)),
                          labelText: 'Numero de visite',
                          hintText: 'Numero de visite'),
                      controller: numVisiteController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                numParcController.clear();
                              },
                              icon: Icon(Icons.clear)),
                          labelText: 'Numero de Parc',
                          hintText: 'Numero de Parc'),
                      controller: numParcController,
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF8FABFE),
                      ),
                      child: ElevatedButton(
                        onPressed: addContainer,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF8FABFE)),
                        ),
                        child: Text('Ajouter',
                            style: TextStyle(fontFamily: 'Poppins')),
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
