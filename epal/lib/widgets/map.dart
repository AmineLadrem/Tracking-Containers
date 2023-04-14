import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

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
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(36.762715, 3.073330),
          zoom: 15,
        ),
        onMapCreated: (controller) {
          _controller = controller;
        },
        polygons: Set.from(_polygons),
      ),
    );
  }
}
