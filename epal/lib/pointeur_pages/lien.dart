import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/style.dart';

DateTime now = DateTime.now();
String formattedTime = DateFormat('HH:mm:ss').format(now);
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

class Lien extends StatefulWidget {
  const Lien({super.key});

  @override
  State<Lien> createState() => _LienState();
}

class _LienState extends State<Lien> {
  Future<void> attacherConteneur(String Cont_ID, String ModNum) async {
    final apiUrl2 = usedIPAddress + '/api/conteneurs/' + Cont_ID;
    final response2 = await http.get(Uri.parse(apiUrl2));
    final decodedResponse2 = json.decode(response2.body);
    if (decodedResponse2['Cont_Status'] == 'À bord') {
      final apiUrl =
          usedIPAddress + '/api/conteneurs/attache/' + Cont_ID + '/' + ModNum;
      await http.put(Uri.parse(apiUrl));

      final apiUrl3 = usedIPAddress +
          '/api/demandes/conducteur/add/0/0/$formattedDate/$formattedTime/$Cont_ID';
      await http.put(Uri.parse(apiUrl3));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              ' Conteneur attaché avec succès + une demande de deplacement a ete envoye !'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      final apiUrl =
          usedIPAddress + '/api/conteneurs/attache/' + Cont_ID + '/' + ModNum;
      final response = await http.put(Uri.parse(apiUrl));

      print(response.body);
      final decodedResponse = json.decode(response.body);

      if (response.statusCode == 200 && decodedResponse['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(' Conteneur attaché avec succès !'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(' Erreur lors de l\'attachement du conteneur !'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> dettacherConteneur(String Cont_ID) async {
    final apiUrl2 = usedIPAddress + '/api/conteneurs/' + Cont_ID;
    final response2 = await http.get(Uri.parse(apiUrl2));
    final decodedResponse2 = json.decode(response2.body);
    print(decodedResponse2);
    final apiUrl = usedIPAddress + '/api/conteneurs/detache/' + Cont_ID;

    final response = await http.put(Uri.parse(apiUrl));
    print(response.body);
    final decodedResponse = json.decode(response.body);

    if (response.statusCode == 200 && decodedResponse['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' Conteneur dettaché avec succès !'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' Erreur lors de l\'attachement du conteneur !'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController modNumController = TextEditingController();
    TextEditingController contIDController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(
          top: 80, left: 10.0, right: 10.0, bottom: 100.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.white,
          child: Container(
              child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 55,
                  ),
                  Image.asset("assets/container.png", width: 100, height: 100),
                  SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    "assets/swap.png",
                    width: 100,
                    height: 100,
                    color: Color(0xFF80CFCC),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Image.asset("assets/gpsModule.png", width: 100, height: 100),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  controller: modNumController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: back,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Module-ID',
                    labelStyle: TextStyle(
                      color: dark,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    hintText: 'Entrez l\'identifaint du module',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    prefixIcon:
                        Icon(Icons.track_changes, color: Colors.green[500]),
                    suffixIcon: IconButton(
                      onPressed: () {
                        modNumController.clear();
                      },
                      icon: Icon(Icons.clear, color: dark),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 90,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      attacherConteneur(
                          contIDController.text, modNumController.text);
                    },
                    child: Container(
                      height: 41,
                      width: 95,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.link),
                            SizedBox(width: 2),
                            Text(' Attacher',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(width: 6),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      dettacherConteneur(contIDController.text);
                    },
                    child: Container(
                      height: 41,
                      width: 95,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.link_off),
                            SizedBox(width: 2),
                            Text(' Détacher',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(width: 6),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
