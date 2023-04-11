import 'package:epal/constants/style.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: light,
          child: Column(
            children: [
              Image.asset('assets/epal.png', width: 200, height: 200),
            ],
          ),
        )),
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
