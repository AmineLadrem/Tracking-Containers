import 'package:flutter/material.dart';

class embarquement extends StatelessWidget {
  const embarquement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Text("embarquement"),
    );
  }
}