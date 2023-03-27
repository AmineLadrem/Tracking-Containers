import 'package:epal/Pages/AjoutConteneur.dart';
import 'package:epal/Pages/ModifierConteneur.dart';
import 'package:epal/Pages/SupprimerConteneur.dart';
import 'package:epal/Pages/GestionConteneurs.dart';
import 'package:epal/Pages/GestionEmployee.dart';
import 'package:epal/Pages/GestionModules.dart';
import 'package:epal/Pages/profile.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:epal/pages/login_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    LoginPage.routeName: (BuildContext context) => LoginPage(),
    AdminHome.routeName: (BuildContext context) => AdminHome(),
    GestionConteneurs.routeName: (BuildContext context) => GestionConteneurs(),
    GestionEmployee.routeName: (BuildContext context) => GestionEmployee(),
    GestionModules.routeName: (BuildContext context) => GestionModules(),
    Profile.routeName: (BuildContext context) => Profile(),
    AjoutConteneur.routeName: (BuildContext context) => AjoutConteneur(),
    ModifierConteneur.routeName: (context) => ModifierConteneur(),
    SupprimerConteneur.routeName: (context) => SupprimerConteneur(),
  };
}
