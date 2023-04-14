import 'package:flutter/material.dart';

class visite extends StatelessWidget {
  const visite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.pink,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Text("visite"),
    );
  }
}
