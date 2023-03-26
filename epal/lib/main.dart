import 'package:epal/Pages/GestionConteneurs.dart';
import 'package:epal/Pages/GestionEmployee.dart';
import 'package:epal/Pages/GestionModules.dart';
import 'package:flutter/material.dart';
import 'package:epal/pages/login_page.dart';
import 'package:epal/pages/home_page.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:epal/auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //enlever le debug marque
      home: const Auth(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        AdminHome.routeName: (context) => HomePage(),
        '/containers': (context) => GestionConteneurs(),
        '/employees': (context) => GestionEmployee(),
        '/modules': (context) => GestionModules(),
      },
    );
  }
}
