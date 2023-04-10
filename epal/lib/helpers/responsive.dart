import 'package:flutter/material.dart';

const int largeScreenSize = 1366;
const int smallScreenSize = 700;
const int customScreenSize = 1100;

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    required this.smallScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < smallScreenSize;

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width > largeScreenSize;

  static bool isCustomScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= smallScreenSize &&
      MediaQuery.of(context).size.width <= customScreenSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double _width = constraints.maxWidth;
      if (_width > largeScreenSize) {
        return largeScreen;
      } else if (_width < largeScreenSize && _width >= smallScreenSize) {
        return largeScreen;
      } else if (_width < smallScreenSize) {
        return smallScreen;
      }
      // If neither condition is met, return a default widget
      return Container();
    });
  }
}
