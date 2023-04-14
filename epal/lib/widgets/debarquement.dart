import 'package:flutter/material.dart';

class debarquement extends StatelessWidget {
  const debarquement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.brown,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Text("debarquement"),
    );
  }
}
