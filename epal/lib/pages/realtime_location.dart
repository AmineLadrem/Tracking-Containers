import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:epal/constants/polygon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_utils/google_maps_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/points.dart';

class RealTime extends StatefulWidget {
  final String Cont_ID;
  final int ModNum;

  RealTime({
    Key? key,
    required this.Cont_ID,
    required this.ModNum,
  }) : super(key: key);

  @override
  State<RealTime> createState() => _RealTimeState();
}

class _RealTimeState extends State<RealTime> {
  late String _Cont_ID;
  late int _ModNum;

  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(36.759760, 3.068675),
    zoom: 15.6,
  );
  late Timer _timer;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getLocationData();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _getLocationData();
    });
    _Cont_ID = widget.Cont_ID;
    _ModNum = widget.ModNum;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _getLocationData() async {
    final response = await http.get(Uri.parse(
        'https://tracking-rtdb-default-rtdb.europe-west1.firebasedatabase.app/' +
            _ModNum.toString() +
            '.json?auth=404QxLl3TtXI6V1eMIb6vbdfvGtMKFCur4COwvzH'));
    final data = jsonDecode(response.body);
    setState(() {
      _currentLocation = LatLng(data['latitude'], data['longitude']);
    });
  }

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  bool _isMapTypeNormal = false;
  @override
  Widget build(BuildContext context) {
    num lat, lon;
    if (_currentLocation != null) {
      lat = _currentLocation!.latitude;
      lon = _currentLocation!.longitude;
    } else {
      lat = 0;
      lon = 0;
    }
    var point = Point(lat, lon);
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

    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      body: Container(
        child: Column(children: [
          SizedBox(
            height: 15.0,
            width: 340,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF80CFCC)),
                  ),
                  onPressed: () {
                    Navigator.pop(
                        context); // Navigate to the previous interface
                  },
                  child: Container(
                    child: Icon(Icons.arrow_back_rounded),
                  ),
                ),
              ),
              SizedBox(
                width: 85,
              ),
              Image.asset("assets/epal.png", width: 164, height: 120),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 550,
                width: 500,
                child: GoogleMap(
                  polygons: Set<Polygon>.of(mylist),
                  mapType: _isMapTypeNormal ? MapType.normal : MapType.hybrid,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _currentLocation != null
                      ? {
                          Marker(
                            markerId: MarkerId('current_location'),
                            position: _currentLocation ?? LatLng(0, 0),
                            infoWindow: InfoWindow(title: _Cont_ID),
                          )
                        }
                      : {},
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 27.0, top: 25),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF80CFCC)),
              ),
              child: Container(
                width: 200,
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sync_alt_outlined, color: Colors.white),
                    SizedBox(width: 10.0),
                    Text(_isMapTypeNormal
                        ? 'Basculer au mode Hybrid'
                        : 'Basculer au mode Normal'),
                  ],
                ),
              ),
              onPressed: () {
                setState(() {
                  _isMapTypeNormal = !_isMapTypeNormal;
                });
              },
            ),
          ),
        ]),
      ),
    );
  }
}
