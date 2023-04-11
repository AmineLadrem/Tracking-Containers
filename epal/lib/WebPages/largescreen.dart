import 'package:epal/constants/style.dart';
import 'package:epal/icons.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: back,
          child: Column(
            children: [
              Card(
                child: Container(
                  width: 220,
                  height: 681.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80CFCC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // handle button press
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(MyFlutterApp.container),
                              SizedBox(width: 2),
                              Text('    Conteneurs    ',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 6),
                              Icon(MyFlutterApp.container),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80CFCC),
                          // elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // handle button press
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.gps_fixed, size: 16),
                              SizedBox(width: 4),
                              Text('Tracker_Module',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.gps_fixed, size: 16),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 540),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF80CFCC),
                          // elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // handle button press
                        },
                        child: Container(
                          height: 20,
                          width: 155,
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.logout, size: 16),
                            SizedBox(width: 4),
                            Text('Se déconnecter',
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Icon(Icons.logout, size: 16),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
        Expanded(
          flex: 5,
          child: Container(
            height: 1000,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Text("data"),
          ),
        )
      ],
    );
  }
}
