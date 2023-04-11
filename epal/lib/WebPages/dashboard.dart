import 'package:epal/WebPages/largescreen.dart';
import 'package:epal/WebPages/smallscreen.dart';
import 'package:epal/helpers/responsive.dart';
import 'package:epal/widgets/top_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Dashboard());
}

class Dashboard extends StatefulWidget {
  static const String routeName = '/dashboard';

  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  final double pi = 3.14159265358979323846;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: topNavigationBar(context, scaffoldkey),
      drawer: Drawer(),
      body: ResponsiveWidget(
          largeScreen: LargeScreen(), smallScreen: SmallScreen()),
    );
  }
}
