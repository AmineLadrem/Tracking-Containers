import 'dart:convert';

import 'package:epal/widgets/realtime_location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/style.dart';

class GererModule extends StatefulWidget {
  const GererModule({super.key});

  @override
  State<GererModule> createState() => _modulesState();
}

class _modulesState extends State<GererModule> {
  final _searchController = TextEditingController();
  Future<List<dynamic>> fetchModules() async {
    final apiUrl = 'http://127.0.0.1:8000/api/modulesuivis';
    final response = await http.get(Uri.parse(apiUrl));
    final moduleList = <dynamic>[];
    final moduleData = json.decode(response.body);

    for (var module in moduleData) {
      moduleList.add(module);
    }
    print(moduleList);
    if (_searchController.text.isNotEmpty) {
      int searchNumber =
          int.parse(_searchController.text); // Convert search text to integer
      moduleList.retainWhere((module) => module['ModNum'] == searchNumber);
    }
    return moduleList;
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
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final ModuleIDController = TextEditingController();
    final ModuleBatterieController = TextEditingController();
    makeApiCall() async {
      final String apiUrl = 'http://127.0.0.1:8000/api/modulesuivis?ModNum=' +
          ModuleIDController.text +
          '&ModBatterie=' +
          ModuleBatterieController.text;
      print(apiUrl);

      final response = await http.post(Uri.parse(apiUrl));

      String data = "{\"latitude\":0,\"longitude\":0}";

      String url =
          'https://tracking-rtdb-default-rtdb.europe-west1.firebasedatabase.app/' +
              ModuleIDController.text +
              '.json?auth=404QxLl3TtXI6V1eMIb6vbdfvGtMKFCur4COwvzH';

      http.Response response2 = await http.patch(Uri.parse(url), body: data);

      print('Response status: ${response2.statusCode}');

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
      child: Row(
        children: [
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
                  SizedBox(height: 20),
                  Expanded(
                    child: FutureBuilder<List<dynamic>>(
                      future: fetchModules(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final _foundModules = snapshot.data!;
                          return ListView.builder(
                            itemCount: _foundModules.length,
                            itemBuilder: (context, index) => Card(
                              key: ValueKey(_foundModules[index]['ModNum']),
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
                                            "assets/gpsModule.png",
                                            width: 100,
                                            height: 100),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        child: Container(
                                          child: Row(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18.0,
                                                    color: dark,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Numero:  ',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: _foundModules[index]
                                                              ['ModNum']
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18.0,
                                                    color: dark,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Batterie:  ',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: _foundModules[index]
                                                              ['ModBatterie']
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18.0,
                                                    color: dark,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Status:  ',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: _foundModules[index]
                                                              ['ModStatus']
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
                                                    fontSize: 18.0,
                                                    color: dark,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'PosistionX:  ',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: _foundModules[index]
                                                              ['PositionX']
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18.0,
                                                    color: dark,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'PosistionY:  ',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: _foundModules[index]
                                                              ['PositionY']
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Visibility(
                                          visible: (_foundModules[index]
                                                      ['ModStatus']
                                                  .toString() ==
                                              'Active'),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    getPosition(
                                                        _foundModules[index]
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
                                                      Icon(Icons.gps_fixed,
                                                          color: dark)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
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
          Container(
            width: 450,
            child: Padding(
              padding: const EdgeInsets.only(top: 98.0, left: 5),
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
                            'Ajouter un Module',
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
                  SizedBox(height: 20),
                  TextField(
                    controller: ModuleIDController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: back,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      labelText: 'Numero de Module',
                      labelStyle: TextStyle(
                        color: dark,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      hintText: 'Numero de Module',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(Icons.track_changes, color: Colors.blue),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ModuleIDController.clear();
                        },
                        icon: Icon(Icons.clear, color: Colors.grey[700]),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: ModuleBatterieController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: back,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      labelText: 'Batterie',
                      labelStyle: TextStyle(
                        color: dark,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      hintText: 'Batterie',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(Icons.battery_charging_full,
                          color: Colors.green),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ModuleBatterieController.clear();
                        },
                        icon: Icon(Icons.clear, color: Colors.grey[700]),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 45,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF8FABFE),
                    ),
                    child: ElevatedButton(
                      onPressed: makeApiCall,
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
        ],
      ),
    );
  }
}
