import 'dart:convert';
import 'package:epal/helpers/devices_tokens.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
  }

  void showNotificationToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Notifications"),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  String? token = await FirebaseMessaging.instance.getToken();
                  print("Token: $token");
                },
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text("get token"),
                ),
              ),
              InkWell(
                onTap: () {
                  sendAndroidNotification();
                },
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text("Notification 2"),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text("Notification 3"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

void sendAndroidNotification() async {
  Map<String, dynamic> jsonBody = {
    "registration_ids": registrationIds,
    "notification": {
      "title": "Alerte",
      "body": "Déplacement du conteneur CMAU 44588 a été détecté",
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
