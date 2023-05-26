import 'dart:math';
import 'package:epal/constants/polygon.dart';
import 'package:epal/constants/points.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/google_maps_utils.dart';

class Location extends StatefulWidget {
  static const String routeName = '/Location';
  @override
  State<Location> createState() => _LocationState();

  final String Cont_ID;
  final String ModNum;
  final double PositionX;
  final double PositionY;
  final double PositionH;

  Location(
      {Key? key,
      required this.Cont_ID,
      required this.ModNum,
      required this.PositionX,
      required this.PositionY,
      required this.PositionH})
      : super(key: key);
}

class _LocationState extends State<Location> {
  late String _Cont_ID;
  late String _ModNum;
  late double _PositionX;
  late double _PositionY;
  late double _PositionH;

  @override
  void initState() {
    super.initState();

    _Cont_ID = widget.Cont_ID;
    _ModNum = widget.ModNum;
    _PositionX = widget.PositionX;
    _PositionY = widget.PositionY;
    _PositionH = widget.PositionH;
  }

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;

  Widget build(BuildContext context) {
    var point = Point(_PositionX, _PositionY);
    String zone = '';
    String parc = '';
    if (PolyUtils.containsLocationPoly(point, debarquement)) {
      zone = 'Debarquement';
      if (PolyUtils.containsLocationPoly(point, dparc1)) {
        parc = 'Parc 1';
      }
      if (PolyUtils.containsLocationPoly(point, dparc2)) {
        parc = 'Parc 2';
      }
    }
    if (PolyUtils.containsLocationPoly(point, embarquement)) {
      zone = 'Embarquement';
      if (PolyUtils.containsLocationPoly(point, eparc1)) {
        parc = 'Parc 1';
      }
      if (PolyUtils.containsLocationPoly(point, eparc2)) {
        parc = 'Parc 2';
      }
      if (PolyUtils.containsLocationPoly(point, eparc3)) {
        parc = 'Parc 3';
      }
      if (PolyUtils.containsLocationPoly(point, eparc4)) {
        parc = 'Parc 4';
      }
      if (PolyUtils.containsLocationPoly(point, eparc5)) {
        parc = 'Parc 5';
      }
      if (PolyUtils.containsLocationPoly(point, eparc6)) {
        parc = 'Parc 6';
      }
    }
    if (PolyUtils.containsLocationPoly(point, livraison)) {
      zone = 'Livraison';
      if (PolyUtils.containsLocationPoly(point, lparc1)) {
        parc = 'Parc 1';
      }
      if (PolyUtils.containsLocationPoly(point, lparc2)) {
        parc = 'Parc 2';
      }
      if (PolyUtils.containsLocationPoly(point, lparc3)) {
        parc = 'Parc 3';
      }
      if (PolyUtils.containsLocationPoly(point, lparc4)) {
        parc = 'Parc 4';
      }
      if (PolyUtils.containsLocationPoly(point, lparc5)) {
        parc = 'Parc 5';
      }
      if (PolyUtils.containsLocationPoly(point, lparc6)) {
        parc = 'Parc 6';
      }
    }
    if (PolyUtils.containsLocationPoly(point, stockage)) {
      zone = 'Stockage';
      if (PolyUtils.containsLocationPoly(point, sparc1)) {
        parc = 'Parc 1';
      }
      if (PolyUtils.containsLocationPoly(point, sparc2)) {
        parc = 'Parc 2';
      }
      if (PolyUtils.containsLocationPoly(point, sparc3)) {
        parc = 'Parc 3';
      }
      if (PolyUtils.containsLocationPoly(point, sparc4)) {
        parc = 'Parc 4';
      }
      if (PolyUtils.containsLocationPoly(point, sparc5)) {
        parc = 'Parc 5';
      }
    }
    if (PolyUtils.containsLocationPoly(point, visite)) {
      zone = 'Visite';
      if (PolyUtils.containsLocationPoly(point, vparc1)) {
        parc = 'Parc 1';
      }
      if (PolyUtils.containsLocationPoly(point, vparc2)) {
        parc = 'Parc 2';
      }
      if (PolyUtils.containsLocationPoly(point, vparc3)) {
        parc = 'Parc 3';
      }
      if (PolyUtils.containsLocationPoly(point, vparc4)) {
        parc = 'Parc 4';
      }
      if (PolyUtils.containsLocationPoly(point, vparc5)) {
        parc = 'Parc 5';
      }
      if (PolyUtils.containsLocationPoly(point, vparc6)) {
        parc = 'Parc 6';
      }
    }
    String getMarkerText(String zone, String parc) {
      String text = 'Zone : $zone\nParc : $parc\nHauteur : $_PositionH ';
      return text;
    }

    String markerText = getMarkerText(zone, parc);
    Set<Marker> _markers = {
      Marker(
        markerId: MarkerId('myLocation'),
        position: LatLng(_PositionX, _PositionY),
        infoWindow: InfoWindow(
          title: 'Conteneur',
          snippet: _Cont_ID, // Set the maximum width of the InfoWindow
        ),
      ),
    };
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      body: Container(
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 20.0,
            width: 350,
          ),
          Image.asset("assets/epal.png", width: 164, height: 120),
          Container(
            height: 558,
            width: 400,
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
          ),
          Container(
            height: 60,
            width: 380,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 0.5,
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                SizedBox(width: 20.0),
                Column(
                  children: [
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Zone:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: 'Urbanist')),
                        SizedBox(height: 5.0),
                        Text(zone, style: TextStyle(fontFamily: 'Urbanist')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Parc:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: 'Urbanist')),
                        SizedBox(height: 5.0),
                        Text(parc, style: TextStyle(fontFamily: 'Urbanist')),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 30.0),
                Icon(Icons.my_location),
                SizedBox(width: 30.0),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('PositionX:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: 'Urbanist')),
                        SizedBox(height: 5.0),
                        Text(_PositionX.toString(),
                            style: TextStyle(fontFamily: 'Urbanist')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('PositionY:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: 'Urbanist')),
                        SizedBox(height: 5.0),
                        Text(_PositionY.toString(),
                            style: TextStyle(fontFamily: 'Urbanist')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Hauteur:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: 'Urbanist')),
                        SizedBox(height: 5.0),
                        Text(_PositionH.toString(),
                            style: TextStyle(fontFamily: 'Urbanist')),
                      ],
                    ),
                  ],
                )
              ]),
            ),
          )
        ])),
      ),
    );
  }
}
