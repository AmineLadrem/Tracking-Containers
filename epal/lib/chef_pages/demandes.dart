import 'dart:convert';
import 'package:epal/chef_pages/liste_demandes.dart';
import 'package:epal/helpers/ipAddresses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:epal/constants/style.dart';
import 'package:epal/helpers/devices_tokens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String formattedTime = DateFormat('HH:mm:ss').format(now);
String formattedDate = DateFormat('yyyy-MM-dd').format(now);
final user = FirebaseAuth.instance.currentUser!;

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

  Future<void> createDemande(
      String date, String time, String contID, int parcDest) async {
    var response = await http
        .get(Uri.parse(usedIPAddress + '/api/utilisateur/' + user.email!));
    var chef = jsonDecode(response.body);

    var response2 =
        await http.get(Uri.parse(usedIPAddress + '/api/demande/$contID'));
    var dem = jsonDecode(response2.body);
    //----------------------------check ida kyn deja une demande-------------------------
    if (dem == 200) {
      Fluttertoast.showToast(
          msg: "Ce conteneur a déjà une demande de déplacement !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
    //--------------------------------------------------------------------------------------

    //--------------------------------create demande--------------------------------------

    var requestBody = jsonEncode({
      'CDP_ID': chef['ID'],
      'CDC_ID': 0,
      'DateDemande': formattedDate,
      'HeureDemande': formattedTime,
      'Cont_ID': contID,
      'ParcDest': parcDest,
      'Status': 'En Attente'
    });

    var response3 = await http.post(
      Uri.parse('$usedIPAddress/api/demande'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    print(response3.statusCode);
    if (response3.statusCode == 200) {
      sendAndroidNotification(selectedParcItem);
      Fluttertoast.showToast(
          msg: "La demande a été créé ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      // Request failed
      Fluttertoast.showToast(
          msg: "Une erreur a été survenue lors de création d \'une demande",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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
          const EdgeInsets.only(top: 80, left: 25.0, right: 25.0, bottom: 10.0),
      child: Column(
        children: [
          ClipRRect(
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
                      padding: const EdgeInsets.only(left: 55.0),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 51.0, bottom: 5),
                            child: Text(
                              'Conteneur-ID',
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
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 70.0),
                            child: TextField(
                              controller: contIDController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: back,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.confirmation_number,
                                    color: dark),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    contIDController.clear();
                                  },
                                  icon: Icon(Icons.clear, color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 65.0),
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
                                width: 264,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: back,
                                ),
                                child: DropdownButton(
                                  underline: SizedBox(), // Remove the underline
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 50.0),
                                    child: Text('Sélectionner un parc'),
                                  ),
                                  value: selectedParcItem,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedParcItem = newValue;
                                    });
                                  },
                                  items:
                                      parcItems.map<DropdownMenuItem>((item) {
                                    return DropdownMenuItem(
                                      value: item['NumParc'],
                                      child: Text(
                                          '                 ${item['NomParc']} - Zone ${item['Zone_ID']}'),
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                    color: dark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  icon:
                                      Icon(Icons.arrow_drop_down, color: dark),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            createDemande(formattedDate, formattedTime,
                                contIDController.text, selectedParcItem);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF80CFCC)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.call_made,
                                color: Colors.white,
                              ),
                              Text(
                                '        Envoyer la demande       ',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 23,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 33.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => listedemande()));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF80CFCC)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.playlist_add_check,
                        color: Colors.white,
                      ),
                      Text(
                        '  Voir ma liste des demandes ',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
      "title": "[EPAL] Demande de déplacement",
      "body": "Nouvelle demande de déplacement vers le parc $selectedParcItem",
      "content_available": true,
      "android": {
        "style": "bigtext",
        "priority": "high",
        "bigTextStyle": {
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
