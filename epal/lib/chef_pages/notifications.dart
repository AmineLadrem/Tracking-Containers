import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
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
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      showNotificationToast(
          event.notification?.title ?? event.notification?.body ?? '');
    });
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

Future<void> sendAndroidNotification() async {
  try {
    http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'key=AAAAN-J_R3k:APA91bEzx_24yCRNQau9alc5v4Y7mhmO9lxQOn7G143Rvfd-rC4LoDdfDBpR9HkCfgjd53IadcrMaWPjQHCo-GrPG5hZEQKiebcoO4BfkFDqV3_Thzp-PfSBYZFuyVNzAiD3rcb2r8tB',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Alerte',
            'title': 'Deplacement d\'un conteneur a ete detecte',
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to':
              'f0by3vd1TqqGCWMpByqNiy:APA91bGjlzlXLOwrk8j3X9ydsLvLsWDIbWle726SRAiw3Sb-i2mYvuz9oLRni-R3fME38tJ5W97jBRMsgsi9xXPXsN4GbrY5bO47ZniOW5qJsVcB0WjlvJ0_sjpGtmP0DFS71nbTpDPs',
        },
      ),
    );
    response;
  } catch (e) {
    e;
  }
}
