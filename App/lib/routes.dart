import 'package:epal/Pages/profile.dart';
import 'package:epal/chef_pages/home.dart';
import 'package:epal/conducteur_pages/cond_demandes.dart';
import 'package:epal/conducteur_pages/home.dart';
import 'package:epal/conducteur_pages/liste_demandes.dart';

import 'package:epal/pages/home.dart';

import 'package:epal/pages/login_page.dart';
import 'package:epal/pointeur_pages/home.dart';
import 'package:flutter/material.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    LoginPage.routeName: (BuildContext context) => LoginPage(),
    AdminHome.routeName: (BuildContext context) => AdminHome(),
    Profile.routeName: (BuildContext context) => Profile(),
    PointeurHome.routeName: (BuildContext context) => PointeurHome(),
    ChefHome.routeName: (BuildContext context) => ChefHome(),
    ConducteurHome.routeName: (BuildContext context) => ConducteurHome(),
    DemCond.routeName: (BuildContext context) => DemCond(),
    ListeDemandesCond.routeName: (BuildContext context) => ListeDemandesCond(),
  };
}
