import 'dart:math';

import 'package:epal/constants/style.dart';
import 'package:epal/constants/polygon.dart';
import 'package:epal/widgets/top_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/google_maps_utils.dart';

class location extends StatefulWidget {
  static const String routeName = '/location';
  @override
  _locationState createState() => _locationState();

  final String ModNum;
  final double PositionX;
  final double PositionY;
  final double PositionH;

  location(
      {Key? key,
      required this.ModNum,
      required this.PositionX,
      required this.PositionY,
      required this.PositionH})
      : super(key: key);
}

class _locationState extends State<location> {
  late String _ModNum;
  late double _PositionX;
  late double _PositionY;
  late double _PositionH;
  BitmapDescriptor? _markerIcon;
  @override
  void initState() {
    super.initState();
    _ModNum = widget.ModNum;
    _PositionX = widget.PositionX;
    _PositionY = widget.PositionY;
    _PositionH = widget.PositionH;
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(30, 30)),
      'assets/gpsModule.png',
    ).then((value) => setState(() {
          _markerIcon = value;
        }));
  }

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var point = Point(_PositionX, _PositionY);
    String zone = '';
    if (PolyUtils.containsLocationPoly(point, psquare1)) {
      zone = 'Zone 1';
    } else if (PolyUtils.containsLocationPoly(point, psquare2)) {
      zone = 'Zone 2';
    } else if (PolyUtils.containsLocationPoly(point, psquare3)) {
      zone = 'Zone 3';
    } else if (PolyUtils.containsLocationPoly(point, psquare4)) {
      zone = 'Zone 4';
    }

    Set<Marker> _markers = {
      Marker(
        markerId: MarkerId('myLocation'),
        position: LatLng(_PositionX, _PositionY),
        infoWindow: InfoWindow(title: zone),
      ),
    };

    return Scaffold(
      key: scaffoldkey,
      appBar: topNavigationBar(context, scaffoldkey),
      body: Container(
          color: light,
          child: Row(
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
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 20,
                                width: 155,
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.arrow_back, size: 16),
                                      SizedBox(width: 4),
                                      Text('  Back to Home',
                                          style: TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: 8),
                                      Icon(Icons.arrow_back, size: 16),
                                    ]),
                              ),
                            ),
                            SizedBox(height: 100),
                            Card(
                              color: back,
                              child: Column(
                                children: [
                                  Image.asset("assets/gpsModule.png",
                                      width: 100, height: 100),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18.0,
                                        color: dark,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Numero:  ',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: _ModNum,
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18.0,
                                        color: dark,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Longitude:  ',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: _PositionX.toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18.0,
                                        color: dark,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Latitude:  ',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: _PositionY.toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18.0,
                                        color: dark,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Hauteur:  ',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: _PositionH.toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF80CFCC),
                                // elevation
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                              child: Container(
                                height: 20,
                                width: 155,
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.arrow_back, size: 16),
                                      SizedBox(width: 4),
                                      Text('  Draw Road',
                                          style: TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: 8),
                                      Icon(Icons.arrow_back, size: 16),
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
                    child: GoogleMap(
                      polylines: {
                        Polyline(
                          polylineId: PolylineId("route"),
                          color: Colors.blue,
                          width: 5,
                        )
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(_PositionX, _PositionY),
                        zoom: 17.0,
                      ),
                      mapType: MapType.hybrid,
                      markers: _markers,
                      polygons: Set<Polygon>.of(mylist),
                    ),
                  ))
            ],
          )),
    );
  }
}
