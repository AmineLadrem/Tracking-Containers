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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

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
void initState() {
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    showNotificationToast(
        event.notification?.title ?? event.notification?.body ?? '');
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );
  final token = await messaging.getToken();
  print(token);

  if (kIsWeb) {
    Get.put(MenuController());
    runApp(MyWebApp());
  } else {
    runApp(MyApp());
  }
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
