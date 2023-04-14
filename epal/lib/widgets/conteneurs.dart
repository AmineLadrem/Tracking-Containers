import 'package:flutter/material.dart';

class containers extends StatelessWidget {
  const containers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Text("containers"),
    );
  }
}
