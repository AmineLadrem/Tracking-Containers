import 'package:epal/Pages/GestionConteneurs.dart';
import 'package:epal/Pages/GestionModules.dart';
import 'package:epal/Pages/ModifierConteneur.dart';
import 'package:epal/Pages/RechercheConteneur.dart';
import 'package:epal/Pages/profile.dart';
import 'package:epal/pages/RechercheModule.dart';
import 'package:epal/pages/home.dart';
import 'package:epal/pages/login_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    LoginPage.routeName: (BuildContext context) => LoginPage(),
    AdminHome.routeName: (BuildContext context) => AdminHome(),
    GestionConteneurs.routeName: (BuildContext context) => GestionConteneurs(),
    GestionModules.routeName: (BuildContext context) => GestionModules(),
    Profile.routeName: (BuildContext context) => Profile(),
    ModifierConteneur.routeName: (BuildContext context) => ModifierConteneur(),
    RechercheModule.routeName: (BuildContext context) => RechercheModule(),
    RechercheConteneur.routeName: (BuildContext context) =>
        RechercheConteneur(),
  };
}
