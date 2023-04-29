import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:epal/constants/polygon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  Future<List<Marker>> fetchMarkers() async {
    final conteneurApiUrl = 'http://127.0.0.1:8000/api/conteneur';
    final suiviApiUrl = 'http://127.0.0.1:8000/api/modulesuivis/';

    final conteneurResponse = await http.get(Uri.parse(conteneurApiUrl));
    final conteneurData = json.decode(conteneurResponse.body);

    final suiviResponse = await http.get(Uri.parse(suiviApiUrl));
    final suiviData = json.decode(suiviResponse.body);

    final markers = <Marker>[];

    for (var conteneur in conteneurData) {
      final suivi =
          suiviData.firstWhere((s) => s['ModNum'] == conteneur['ModNum']);
      final positionX = suivi['PositionX'];
      final positionY = suivi['PositionY'];
      final markerText = '${conteneur['Cont_ID']}';

      final marker = Marker(
        markerId: MarkerId(markerText),
        position: LatLng(positionX, positionY),
        infoWindow: InfoWindow(title: markerText),
      );

      markers.add(marker);
    }

    return markers;
  }

  bool _isMapTypeNormal = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Marker>>(
              future: fetchMarkers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                    polylines: {
                      Polyline(
                        polylineId: PolylineId("route"),
                        color: Colors.blue,
                        width: 5,
                      ),
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(36.760071, 3.067502),
                      zoom: 15.5,
                    ),
                    mapType: _isMapTypeNormal ? MapType.normal : MapType.hybrid,
                    markers: Set<Marker>.of(snapshot.data!),
                    polygons: Set<Polygon>.of(mylist),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching markers'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF80CFCC)),
            ),
            child: Container(
              width: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sync_alt_outlined, color: Colors.white),
                  Text(_isMapTypeNormal
                      ? 'Switch to Hybrid'
                      : 'Switch to Normal'),
                  Icon(Icons.sync_alt_outlined, color: Colors.white),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                _isMapTypeNormal = !_isMapTypeNormal;
              });
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
