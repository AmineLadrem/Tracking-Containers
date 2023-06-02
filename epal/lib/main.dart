import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:epal/WebPages/LoginPage.dart';
import 'package:epal/WebRoutes.dart';
import 'package:epal/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:epal/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:epal/firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

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

  runApp(kIsWeb ? MyWebApp() : MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: Routes.routes,
    );
  }
}

class MyWebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "EPAL | Dashboard",
      debugShowCheckedModeBanner: false,
      home: WebLoginPage(),
      initialRoute: 'login',
      routes: WebRoutes.routes,
    );
  }
}
