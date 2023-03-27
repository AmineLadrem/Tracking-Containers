import 'package:epal/Pages/AjoutConteneur.dart';
import 'package:epal/Pages/ModifierConteneur.dart';
import 'package:epal/Pages/SupprimerConteneur.dart';
import 'package:epal/Pages/GestionConteneurs.dart';
import 'package:epal/Pages/GestionEmployee.dart';
import 'package:epal/Pages/GestionModules.dart';
import 'package:epal/Pages/profile.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:epal/routes.dart';
import 'package:flutter/material.dart';
import 'package:epal/pages/login_page.dart';
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
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: Routes.routes,
    );
  }
}
