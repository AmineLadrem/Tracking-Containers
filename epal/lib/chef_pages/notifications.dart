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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String? title = message.notification!.title;
      String? body = message.notification!.body;
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: title,
              body: body,
              category: NotificationCategory.Event,
              notificationLayout: NotificationLayout.BigPicture,
              bigPicture: 'assets/images/epal_logo.png'),
          actionButtons: [
            NotificationActionButton(
              key: 'READ',
              label: 'Read',
              buttonType: ActionButtonType.Default,
              enabled: true,
              icon: 'assets/images/epal_logo.png',
            )
          ]);
      AwesomeNotifications().actionStream.listen((receivedNotification) {
        if (receivedNotification.buttonKeyPressed == 'READ') {
          Fluttertoast.showToast(msg: "Read Notification");
        }
      });
    });
    // Initialize awesome_notifications
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
                  child: Text("get token "),
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
            'body': 'Amine',
            'title': 'Alerte',
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to':
              'fwiajmIAS-mGNi9EvMgB4I:APA91bFzCtv_Z_1jdZPG366giI_X5Dy6KHVyJVtf48_PZQ4HiDQUfBWZ0KnbxSFirY8qepRLkemZKRW74p7od6tVQx0AiUl6wGOa07cJRd8JHy2rkY0c_NvWybfKl_VZ1QwlU5xZTOFQ',
        },
      ),
    );
    response;
  } catch (e) {
    e;
  }
}
