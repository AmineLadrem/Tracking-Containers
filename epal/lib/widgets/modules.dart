import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class modules extends StatefulWidget {
  const modules({super.key});

  @override
  State<modules> createState() => _modulesState();
}

class _modulesState extends State<modules> {
  @override
  Widget build(BuildContext context) {
    GoogleMapController? mapController;
    Set<Marker> markers = Set(); //markers for google map
    LatLng showLocation = LatLng(27.7089427, 85.3086209);
    //location to show in map //contrller for Google ma
    return Container(
      height: 1000,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: GoogleMap(
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: showLocation, //initial position
          zoom: 10.0, //initial zoom level
        ),
        markers: markers, //markers to show on map
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}
