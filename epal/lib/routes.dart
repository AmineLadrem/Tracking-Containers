import 'package:epal/Pages/profile.dart';

import 'package:epal/pages/home.dart';
import 'package:epal/pages/location.dart';
import 'package:epal/pages/login_page.dart';
import 'package:epal/pointeur_pages/home.dart';
import 'package:flutter/material.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    LoginPage.routeName: (BuildContext context) => LoginPage(),
    AdminHome.routeName: (BuildContext context) => AdminHome(),
    Profile.routeName: (BuildContext context) => Profile(),
    PointeurHome.routeName: (BuildContext context) => PointeurHome(),
  };
}
