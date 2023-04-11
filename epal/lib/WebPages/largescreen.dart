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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(MyFlutterApp.container),
                              SizedBox(width: 4),
                              Text('    Conteneurs     ',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.gps_fixed),
                              SizedBox(width: 4),
                              Text('Tracker_Module',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.gps_fixed),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.logout),
                              SizedBox(width: 4),
                              Text('Se déconnecter',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.logout),
                            ],
                          ),
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
              color: Colors.red,
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
