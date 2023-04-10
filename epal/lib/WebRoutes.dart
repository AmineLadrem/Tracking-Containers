import 'package:epal/WebPages/LoginPage.dart';
import 'package:flutter/material.dart';

class WebRoutes {
  static final routes = <String, WidgetBuilder>{
    WebLoginPage.routeName: (BuildContext context) => WebLoginPage(),
  };
}
