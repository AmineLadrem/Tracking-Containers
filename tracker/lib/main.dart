import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:tracker/firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:tracker/ipAddresses.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  String? title = message.notification?.title;
  String? body = message.notification?.body;
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 123,
          channelKey: 'basic_channel',
          title: title,
          body: body,
          category: NotificationCategory.Call,
          largeIcon: 'https://i.postimg.cc/xTnb0c7V/container.png',
          displayOnForeground: true,
          displayOnBackground: true,
          showWhen: true,
          wakeUpScreen: true,
          autoDismissible: false,
          backgroundColor: Colors.blueGrey,
          notificationLayout: NotificationLayout.Default),
      actionButtons: [
        NotificationActionButton(
          key: 'REJECT',
          label: 'OK',
          buttonType: ActionButtonType.DisabledAction,
        ),
      ]);
  AwesomeNotifications().actionStream.listen((receivedNotification) {});
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kIsWeb) {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          playSound: true,
          enableVibration: true,
          channelShowBadge: true,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          importance: NotificationImportance.High,
        )
      ],
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final token = await messaging.getToken();
    print(token);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;
  TextEditingController _numberController =
      TextEditingController(text: '2'); // New
  bool notificationSent = false;
  var duration = const Duration(seconds: 4);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // ...

    // Get the current position and continuously update it
    Geolocator.getPositionStream().listen((Position position) async {
      setState(() {
        _currentPosition = position;
      });

      _sendDataToFirebase(position);
      var container = await http.get(
        Uri.parse(usedIPAddress +
            '/api/conteneur/modulesuivi/' +
            _numberController.text),
        headers: headers,
      );

      var containerData = jsonDecode(container.body);
      var demande = await http.get(
        Uri.parse(usedIPAddress +
            '/api/demande/conteneur/' +
            containerData['Cont_ID']),
        headers: headers,
      );

      var demandeData = jsonDecode(demande.body);
      print(demandeData);

      if (containerData['NumParc'] != 0 &&
          demandeData == 1 &&
          notificationSent == false) {
        sendAndroidNotification(containerData['Cont_ID']);
        notificationSent = true;
      }

      sleep(duration);
    });
  }

  Future<void> _sendDataToFirebase(Position position) async {
    String latitude = position.latitude.toStringAsFixed(6);
    String longitude = position.longitude.toStringAsFixed(6);
    String data = "{\"latitude\":$latitude,\"longitude\":$longitude}";

    String url =
        'https://tracking-rtdb-default-rtdb.europe-west1.firebasedatabase.app/${_numberController.text}.json?auth=404QxLl3TtXI6V1eMIb6vbdfvGtMKFCur4COwvzH'; // Updated URL
    var response2 = await http.put(
        Uri.parse(usedIPAddress +
            '/api/modulesuivis/${_numberController.text}/' + // Updated API endpoint
            latitude +
            "/" +
            longitude),
        headers: headers);

    http.Response response = await http.patch(Uri.parse(url), body: data);

    print('Response status: ${response.statusCode}');
    print('Response status: ${response2.statusCode}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocation Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              // New
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number',
              ),
            ),
            SizedBox(height: 16),
            if (_currentPosition != null)
              Text(
                'Latitude: ${_currentPosition!.latitude}\nLongitude: ${_currentPosition!.longitude}',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            else
              Text(
                'Getting location...',
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}

void sendAndroidNotification(dynamic Cont_ID) async {
  Map<String, dynamic> jsonBody = {
    "registration_ids": [
      "f0by3vd1TqqGCWMpByqNiy:APA91bGjlzlXLOwrk8j3X9ydsLvLsWDIbWle726SRAiw3Sb-i2mYvuz9oLRni-R3fME38tJ5W97jBRMsgsi9xXPXsN4GbrY5bO47ZniOW5qJsVcB0WjlvJ0_sjpGtmP0DFS71nbTpDPs",
      "crjoYJtVTCKs9cISfrivbN:APA91bHRSjljdXgsH4FtiWVm6OxZWZo4t26aQfyrQT2AW9Qv0BNVFh7aiClr7c9x4LjOvEj9y4Wn6ZJei00zilmP3qnDAMJlK9_OamR-hLx7TOvcIxQmB8kEucHNVLm9JDJdCWL_sPA7",
      "dqEiroImTgGnn_ri885dnp:APA91bF52Ro5Iy2VAbh095jEGSdd20qufDWM1YXrVck1anxJyrGJDAJXGi9lO5WF3ARJoFJohrqLYPFrzsnTl02-zxLwpNcBp_QwvvOn7Cg6B3l4vGeD5dSPA3rZqV2fqKpGPOYwaSOs"
    ],
    "notification": {
      "title": "[EPAL] Déplacement non autorisé ! ! !",
      "body": "Conteneur $Cont_ID est en déplacement non autorisé ",
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
