import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class GestionModules extends StatelessWidget {
  const GestionModules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modules')),
      body: Center(child: Text('Modules')),
    );
  }
}
