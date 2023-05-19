import 'dart:convert';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:http/http.dart' as http;
import 'package:epal/constants/style.dart';
import 'package:flutter/material.dart';

class Demandes extends StatefulWidget {
  const Demandes({super.key});

  @override
  State<Demandes> createState() => _DemandesState();
}

class _DemandesState extends State<Demandes> {
  List<dynamic> parcItems = [];
  TextEditingController contIDController = TextEditingController();
  dynamic selectedParcItem;
  Future<void> fetchParc() async {
    final response = await http.get(Uri.parse(usedIPAddress + '/api/parcs'));
    if (response.statusCode == 200) {
      final List<dynamic> parsedItems = json.decode(response.body);
      setState(() {
        parcItems = parsedItems.where((item) => item['NbrDispo'] > 0).toList();
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchParc();
  }

  void printSelectedItem() {
    print(selectedParcItem);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 80, left: 15.0, right: 15.0, bottom: 70.0),
      child: ClipRRect(
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
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 150.0),
                  child: TextField(
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
                      hintText: 'Entrez l\'identifiant du conteneur',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(Icons.confirmation_number, color: dark),
                      suffixIcon: IconButton(
                        onPressed: () {
                          contIDController.clear();
                        },
                        icon: Icon(Icons.clear, color: dark),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 185.0),
                  child: Text(
                    'Déplacer ce conteneur vers:',
                    style: TextStyle(
                      color: dark,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: back,
                      ),
                      child: DropdownButton(
                        underline: SizedBox(), // Remove the underline
                        hint: Text('Sélectionner un parc'),
                        value: selectedParcItem,
                        onChanged: (newValue) {
                          setState(() {
                            selectedParcItem = newValue;
                          });
                        },
                        items: parcItems.map<DropdownMenuItem>((item) {
                          return DropdownMenuItem(
                            value: item['NumParc'],
                            child: Text(
                                '${item['NomParc']} - Zone ${item['Zone_ID']}'),
                          );
                        }).toList(),
                        style: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        icon: Icon(Icons.arrow_drop_down, color: dark),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
