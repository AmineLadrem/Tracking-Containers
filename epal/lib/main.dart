import 'package:epal/WebPages/LoginPage.dart';
import 'package:epal/WebRoutes.dart';
import 'package:epal/routes.dart';
import 'package:flutter/material.dart';
import 'package:epal/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:epal/firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
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
      debugShowCheckedModeBanner: false,
      home: WebLoginPage(),
    );
  }
}
