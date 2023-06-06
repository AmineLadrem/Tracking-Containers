import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    //----------------------------check if module is already attached to a container--------------------------
    final moduleUrl = usedIPAddress + '/api/modulesuivis/' + ModNum;
    final responseModule = await http.get(Uri.parse(moduleUrl));
    final decodedResponseModule = json.decode(responseModule.body);

    if (decodedResponseModule['ModStatus'] == 'Active') {
      Fluttertoast.showToast(
          msg: "Ce module de suivi est déjà lié à un conteneur !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    } else {
      final apiUrl4 = usedIPAddress + '/api/modulesuivis/status/$ModNum';
      await http.put(Uri.parse(apiUrl4));
    }
    //---------------------------------------------------------------------------------------------------------

    //-----------------------------check if container rah a board--------------------------------------
    var apiUrl2 = usedIPAddress + '/api/conteneurs/' + Cont_ID;
    var response2 = await http.get(Uri.parse(apiUrl2));
    var decodedResponse2 = json.decode(response2.body);
    if (decodedResponse2['Cont_Status'] == 'À bord') {
      final apiUrl =
          usedIPAddress + '/api/conteneurs/attache/' + Cont_ID + '/' + ModNum;
      await http.put(Uri.parse(apiUrl));

      final apiUrl3 = usedIPAddress +
          '/api/demandes/conducteur/add/0/0/$formattedDate/$formattedTime/$Cont_ID';
      await http.put(Uri.parse(apiUrl3));
      apiUrl2 = usedIPAddress + '/api/conteneurs/' + Cont_ID;
      response2 = await http.get(Uri.parse(apiUrl2));
      decodedResponse2 = json.decode(response2.body);
      sendAndroidNotification('Zone de debarquement');
      Fluttertoast.showToast(
          msg:
              "Module de suivi est lié au conteneur avec succès ! et une demande de déplacement est envoyée  ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      //----------------------------------------------------------ida marahsh a board-------------------------------------
      final apiUrl =
          usedIPAddress + '/api/conteneurs/attache/' + Cont_ID + '/' + ModNum;
      final response = await http.put(Uri.parse(apiUrl));

      final decodedResponse = json.decode(response.body);
      if (response.statusCode == 200 && decodedResponse['success']) {
        Fluttertoast.showToast(
            msg: "Module de suivi est lié au conteneur avec succès !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Erreur lors de l\'attachement du conteneur !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future<void> dettacherConteneur(String Cont_ID) async {
    final apiUrl2 = usedIPAddress + '/api/conteneurs/' + Cont_ID;
    final response2 = await http.get(Uri.parse(apiUrl2));
    final decodedResponse2 = json.decode(response2.body);
    if (decodedResponse2['ModNum'] == 0) return null;
    final apiUrl4 = usedIPAddress +
        '/api/modulesuivis/status/' +
        decodedResponse2['ModNum'].toString();
    await http.put(Uri.parse(apiUrl4));
    final apiUrl = usedIPAddress + '/api/conteneurs/detache/' + Cont_ID;
    final response = await http.put(Uri.parse(apiUrl));
    final decodedResponse = json.decode(response.body);

    if (response.statusCode == 200 && decodedResponse['success']) {
      Fluttertoast.showToast(
          msg: "Module de suivi est détaché avec succès !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: " Erreur lors du détachement du module !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController modNumController = TextEditingController();
    TextEditingController contIDController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(
          top: 80, left: 20.0, right: 20.0, bottom: 100.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.white,
          child: Container(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 55,
                    ),
                    Image.asset("assets/container.png",
                        width: 100, height: 100),
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
                    Image.asset("assets/gpsModule.png",
                        width: 100, height: 100),
                  ],
                ),
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
                height: 20,
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
                            Icon(
                              Icons.link,
                              size: 30,
                            ),
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
                            Icon(
                              Icons.link_off,
                              size: 30,
                            ),
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

void sendAndroidNotification(dynamic selectedParcItem) async {
  Map<String, dynamic> jsonBody = {
    "registration_ids": [
      "dPv-nHbJRfmazzhEGa9Z51:APA91bHbUftyBjIxE3jcP2nBxYTJu0ujDMo2_ApJEisICTSKbLueHiBzUGiyJJJzaU2iJkaaEFe7_N3kH3iayAS4O5jAM-6bxWV42leZGCZQED1of_DOozjjEj2Ps-g1aWdo5XPoUZ22",
      "dCsgc3qmR5mOQ5xt2_kjif:APA91bEQH3g4Vk3WIJctkG2zFpoc26-M-ePkPj8tc4eCEbpJBNRw_5SvbJKiVX5UMOkGZvG7_1-TLT5GSn37644rr5Mp1hJCcPhcrDTNhomLZuXYot6H_BH-pA1B9_WjXEZvhWOixsZJ"
    ],
    "notification": {
      "title": "[EPAL] Nouvelle demande de déplacement",
      "body": "Nouvelle demande de déplacement vers le parc $selectedParcItem",
      "content_available": true,
      "android": {
        "style": "bigtext",
        "priority": "high",
        "bigTextStyle": {
          "contentTitle": "Déplacement d'un conteneur a été détecté",
          "summaryText": "Alerte",
          "bigText": "Detailed description of the alert goes here."
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
