import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
    // Initialize awesome_notifications
    AwesomeNotifications().initialize(
      null, // Replace null with your 'notificationChannel' configuration
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic notifications',
          defaultColor: Colors.blue,
          ledColor: Colors.blue,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose awesome_notifications resources
    AwesomeNotifications().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Notifications"),
          ElevatedButton(
            onPressed: sendNotification,
            child: Text("Send Notification"),
          ),
        ],
      ),
    );
  }

  void sendNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'New Notification',
        body: 'This is a notification created by pressing the button.',
      ),
    );
  }
}
