import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class modules extends StatelessWidget {
  const modules({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Text("modules"),
    );
  }
}
