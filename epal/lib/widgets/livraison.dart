import 'package:flutter/material.dart';

class livraison extends StatelessWidget {
  const livraison({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Text("livraison"),
    );
  }
}
