import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:tracker/ipAddresses.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled');
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Location permissions are denied (actual value: $permission)');
        return;
      }
    }

    // Get the current position and continuously update it
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _sendDataToFirebase(position);
    });
  }

  Future<void> _sendDataToFirebase(Position position) async {
    String latitude = position.latitude.toStringAsFixed(6);
    String longitude = position.longitude.toStringAsFixed(6);
    String data = "{\"latitude\":$latitude,\"longitude\":$longitude}";

    String url =
        'https://tracking-rtdb-default-rtdb.europe-west1.firebasedatabase.app/2.json?auth=404QxLl3TtXI6V1eMIb6vbdfvGtMKFCur4COwvzH';
    var response2 = await http.put(
      Uri.parse(usedIPAddress +
          '/api/modulesuivis/2/' +
          latitude +
          "/" +
          longitude +
          "/0"),
    );

    http.Response response = await http.patch(Uri.parse(url), body: data);

    print('Response status: ${response.statusCode}');
    print('Response status: ${response2.statusCode}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocation Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                'Latitude: ${_currentPosition!.latitude}\nLongitude: ${_currentPosition!.longitude}',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            else
              Text(
                'Getting location...',
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
