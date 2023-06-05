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
  TextEditingController _numberController =
      TextEditingController(text: '2'); // New

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // ...

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
        'https://tracking-rtdb-default-rtdb.europe-west1.firebasedatabase.app/${_numberController.text}.json?auth=404QxLl3TtXI6V1eMIb6vbdfvGtMKFCur4COwvzH'; // Updated URL
    var response2 = await http.put(
        Uri.parse(usedIPAddress +
            '/api/modulesuivis/${_numberController.text}/' + // Updated API endpoint
            latitude +
            "/" +
            longitude),
        headers: headers);

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
            TextField(
              // New
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number',
              ),
            ),
            SizedBox(height: 16),
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
