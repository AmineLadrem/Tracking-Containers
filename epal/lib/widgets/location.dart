import 'package:epal/constants/style.dart';
import 'package:epal/widgets/top_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  void initState() {
    super.initState();
    _ModNum = widget.ModNum;
    _PositionX = widget.PositionX;
    _PositionY = widget.PositionY;
    _PositionH = widget.PositionH;
  }

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;

  List<Polygon> _polygons = [
    Polygon(
      polygonId: PolygonId('square1'),
      points: [
        LatLng(36.764500, 3.070831),
        LatLng(36.764500, 3.075830),
        LatLng(36.760500, 3.075830),
        LatLng(36.760500, 3.070831),
      ],
      strokeColor: Colors.red,
      strokeWidth: 2,
      fillColor: Colors.red.withOpacity(0.3),
    ),
    Polygon(
      polygonId: PolygonId('square3'),
      points: [
        LatLng(36.759586, 3.066584),
        LatLng(36.757379, 3.066652),
        LatLng(36.757393, 3.069241),
        LatLng(36.759575, 3.069203),
      ],
      strokeColor: Colors.blue,
      strokeWidth: 2,
      fillColor: Colors.blue.withOpacity(0.3),
    ),
    Polygon(
      polygonId: PolygonId('square3'),
      points: [
        LatLng(36.761924, 3.066640),
        LatLng(36.759702, 3.066584),
        LatLng(36.759630, 3.069592),
        LatLng(36.761906, 3.069567),
      ],
      strokeColor: Colors.blue,
      strokeWidth: 2,
      fillColor: Colors.blue.withOpacity(0.3),
    ),
    Polygon(
      polygonId: PolygonId('square2'),
      points: [
        LatLng(36.763000, 3.071331),
        LatLng(36.763000, 3.074830),
        LatLng(36.761000, 3.074830),
        LatLng(36.761000, 3.071331),
      ],
      strokeColor: Colors.blue,
      strokeWidth: 2,
      fillColor: Colors.blue.withOpacity(0.3),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const google_API = "AIzaSyAg0fdIUbAOiJeN9a-LHIcIdQQs8eNL-co";
    Set<Marker> _markers = {
      Marker(
        markerId: MarkerId('myLocation'),
        position: LatLng(_PositionX, _PositionY),
        infoWindow: InfoWindow(title: 'My Location'),
      ),
      Marker(markerId: MarkerId('A'), position: LatLng(36.761000, 3.071331)),
      Marker(markerId: MarkerId('B'), position: LatLng(36.761000, 3.074830)),
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
                      polygons: Set.from(_polygons),
                    ),
                  ))
            ],
          )),
    );
  }
}
