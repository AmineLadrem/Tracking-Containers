import 'package:epal/WebPages/LoginPage.dart';
import 'package:epal/WebPages/dashboard.dart';
import 'package:flutter/material.dart';

const OverViewPage = 'Overview';
const DriversPageRoute = 'Drivers';
const ClientsPageRoute = 'Clients';
const AuthenticationPageRoute = 'Authentication';

List sideMenuItems = [
  OverViewPage,
  DriversPageRoute,
  ClientsPageRoute,
  AuthenticationPageRoute,
];

class WebRoutes {
  static final routes = <String, WidgetBuilder>{
    WebLoginPage.routeName: (BuildContext context) => WebLoginPage(),
    Dashboard.routeName: (BuildContext context) => Dashboard(),
  };
}
