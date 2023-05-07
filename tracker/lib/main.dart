import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Geolocator Example')),
        body: Center(child: GeolocatorWidget()),
      ),
    );
  }
}

class GeolocatorWidget extends StatefulWidget {
  const GeolocatorWidget({Key? key}) : super(key: key);

  @override
  _GeolocatorWidgetState createState() => _GeolocatorWidgetState();
}

class _GeolocatorWidgetState extends State<GeolocatorWidget> {
  late StreamSubscription<Position> _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  void _requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Permission granted, start listening for location updates
      _positionStreamSubscription =
          Geolocator.getPositionStream().listen((position) async {
            print('Location update: ${position.latitude}, ${position.longitude}');
            String data =
                "{\"latitude\":${position.latitude},\"longitude\":${position.longitude}}";

            String url =
                'https://tracking-rtdb-default-rtdb.europe-west1.firebasedatabase.app/2.json?auth=404QxLl3TtXI6V1eMIb6vbdfvGtMKFCur4COwvzH';
            http.Response response = await http.patch(Uri.parse(url), body: data);
            print('Response status: ${response.statusCode}');
          });
    }
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
