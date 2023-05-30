import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:epal/constants/polygon.dart';
import 'package:epal/constants/style.dart';
import 'package:epal/widgets/top_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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
    target: LatLng(36.759882, 3.069828),
    zoom: 16,
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

  BitmapDescriptor? customIcon;
  final defaultIcon = BitmapDescriptor.defaultMarker;

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      configuration = configuration.copyWith(
          size: Size(48, 48)); // Set the desired width and height

      BitmapDescriptor.fromAssetImage(configuration, 'assets/container.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
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
                                Image.asset("assets/container.png",
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
                                        text: _Cont_ID.toString(),
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
                                        text: _currentLocation != null
                                            ? _currentLocation!.latitude
                                                .toString()
                                            : '',
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
                                        text: _currentLocation != null
                                            ? _currentLocation!.longitude
                                                .toString()
                                            : '',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF80CFCC)),
                            ),
                            child: Container(
                              width: 160,
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.sync_alt_outlined,
                                      color: Colors.white),
                                  Text(_isMapTypeNormal
                                      ? 'Switch to Hybrid'
                                      : 'Switch to Normal'),
                                  Icon(Icons.sync_alt_outlined,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _isMapTypeNormal = !_isMapTypeNormal;
                              });
                            },
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
                  polygons: Set<Polygon>.of(mylist),
                  mapType: _isMapTypeNormal ? MapType.normal : MapType.hybrid,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _currentLocation != null
                      ? {
                          Marker(
                            // icon: customIcon ?? defaultIcon,
                            markerId: MarkerId('current_location'),
                            position: _currentLocation ?? LatLng(0, 0),
                            infoWindow: InfoWindow(title: _Cont_ID),
                          )
                        }
                      : {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
