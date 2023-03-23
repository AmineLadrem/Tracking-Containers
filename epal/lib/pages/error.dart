import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<ErrorPage> createState() => _HomePageState();
}

class _HomePageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ErrorPage'),
      ),
      body: Text('ErrorPage'),
    );
  }
}
