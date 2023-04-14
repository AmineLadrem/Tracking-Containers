import 'package:flutter/material.dart';

class deplacement extends StatelessWidget {
  const deplacement({super.key});

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
      child: Text("deplacement"),
    );
  }
}
