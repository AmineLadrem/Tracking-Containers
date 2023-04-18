import 'dart:convert';
import 'package:epal/widgets/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../constants/style.dart';

class GererModule extends StatefulWidget {
  const GererModule({super.key});

  @override
  State<GererModule> createState() => _modulesState();
}

class _modulesState extends State<GererModule> {
  Future<List<dynamic>> fetchModules() async {
    final apiUrl = 'http://127.0.0.1:8000/api/modulesuivis';
    final response = await http.get(Uri.parse(apiUrl));
    final moduleList = <dynamic>[];
    final moduleData = json.decode(response.body);

    for (var module in moduleData) {
      moduleList.add(module);
    }
    print(moduleList);
    return moduleList;
  }

  Future<List<dynamic>> _foundModules = Future.value([]);

  @override
  void initState() {
    _foundModules = fetchModules();
    super.initState();
  }

  void _runFilter(String keyword) {
    Future<List<dynamic>> results = Future.value([]);
    if (keyword.isEmpty) {
      results = fetchModules();
    } else {
      results = _foundModules.then((moduleList) {
        return moduleList
            .where((module) => module['ModNum'].contains(keyword))
            .toList();
      });
    }
    setState(() {
      _foundModules = results;
    });
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

    _launchUrl() async {
      final Uri _url = Uri.parse('https://flutter.dev');
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }

    final Uri _url = Uri.parse('https://flutter.dev');
    return Container(
        height: 1000,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: dark,
            width: 1,
          ),
        ),
        child: Container(
          child: Column(
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                            width: 30,
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
                                                          text: 'Numero:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: _foundModules[
                                                                      index]
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
                                          SizedBox(
                                            width: 100,
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
                                                          text: 'Batterie:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: _foundModules[
                                                                      index][
                                                                  'ModBatterie']
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontFamily: 'Poppins',
                                                        color: dark,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: 'Status:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: _foundModules[
                                                                  index]
                                                              ['ModStatus'],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
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
                                                          text: 'PositionX:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: _foundModules[
                                                                      index]
                                                                  ['PositionX']
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontFamily: 'Poppins',
                                                        color: dark,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: 'PositionY:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: _foundModules[
                                                                      index]
                                                                  ['PositionY']
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontFamily: 'Poppins',
                                                        color: dark,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: 'PositionH:  ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: _foundModules[
                                                                      index]
                                                                  ['PositionH']
                                                              .toString(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 400,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              location(
                                                            ModNum: _foundModules[
                                                                        index]
                                                                    ['ModNum']
                                                                .toString(),
                                                            PositionX:
                                                                _foundModules[
                                                                        index][
                                                                    'PositionX'],
                                                            PositionY:
                                                                _foundModules[
                                                                        index][
                                                                    'PositionY'],
                                                            PositionH:
                                                                _foundModules[
                                                                        index][
                                                                    'PositionH'],
                                                          ),
                                                        ),
                                                      );
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
            ],
          ),
        ));
  }
}
