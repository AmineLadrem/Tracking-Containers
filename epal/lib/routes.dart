import 'package:epal/Pages/AjoutConteneur.dart';
import 'package:epal/Pages/GestionConteneurs.dart';
import 'package:epal/Pages/GestionEmployee.dart';
import 'package:epal/Pages/GestionModules.dart';
import 'package:epal/Pages/ModifierConteneur.dart';
import 'package:epal/Pages/profile.dart';
import 'package:epal/pages/AjoutModule.dart';
import 'package:epal/pages/RechercheModule.dart';
import 'package:epal/pages/SupprimerConteneur.dart';
import 'package:epal/pages/admin_home.dart';
import 'package:epal/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Routes {
  static final user = FirebaseAuth.instance.currentUser!;
  static final ContID = TextEditingController();
  static final ContType = TextEditingController();
  static final ContDateArrPr = TextEditingController();
  static final ContDateArr = TextEditingController();
  static final status = TextEditingController();
  static final EmployeID = TextEditingController();
  static final ModuleID = TextEditingController();

  static void dispose() {
    ContID.dispose();
    ContType.dispose();
    ContDateArrPr.dispose();
    ContDateArr.dispose();
    status.dispose();
    EmployeID.dispose();
    ModuleID.dispose();
  }

  static int _selectedIndex = 1;

  static void _onItemTapped(int index, BuildContext context) {
    _selectedIndex = index;

    switch (index) {
      case 0:
        // Navigate to the home page
        Navigator.pushNamed(context, AdminHome.routeName);
        break;
      case 1:
        // Navigate to the search page
        Navigator.pushNamed(context, GestionModules.routeName);
        break;
      case 2:
        // Navigate to the containers page
        Navigator.pushNamed(context, GestionConteneurs.routeName);
        break;
      case 3:
        // Navigate to the employees page
        Navigator.pushNamed(context, GestionEmployee.routeName);
        break;
      case 4:
        // Navigate to the profile page
        Navigator.pushNamed(context, Profile.routeName);
        break;
    }
  }

  static final routes = <String, WidgetBuilder>{
    LoginPage.routeName: (BuildContext context) => LoginPage(),
    AdminHome.routeName: (BuildContext context) => AdminHome(),
    GestionConteneurs.routeName: (BuildContext context) => GestionConteneurs(),
    GestionEmployee.routeName: (BuildContext context) => GestionEmployee(),
    GestionModules.routeName: (BuildContext context) => GestionModules(),
    Profile.routeName: (BuildContext context) => Profile(),
    AjoutConteneur.routeName: (BuildContext context) => AjoutConteneur(),
    SupprimerConteneur.routeName: (BuildContext context) =>
        SupprimerConteneur(),
    ModifierConteneur.routeName: (BuildContext context) => ModifierConteneur(),
    AjoutModule.routeName: (BuildContext context) => AjoutModule(),
    RechercheModule.routeName: (BuildContext context) => RechercheModule(),
  };
}
