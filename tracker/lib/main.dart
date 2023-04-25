import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Start the background service
  FlutterBackgroundService().startService();
  runApp(MyApp());
}

void onStart() {
  // Start the timer when the background service is started
  Timer.periodic(Duration(seconds: 2), (timer) {
    print('Hello from background service!');
    // Update the service status
    FlutterBackgroundService().on('onStart').listen((event) {
      // Here is the current status
      // You can use it to update your UI or send it to the server
      print(event);
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Service Demo',
      home: BackgroundService(),
    );
  }
}

class BackgroundService extends StatefulWidget {
  @override
  _BackgroundServiceState createState() => _BackgroundServiceState();
}

class _BackgroundServiceState extends State<BackgroundService> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    // Start the background service
    FlutterBackgroundService().startService();
    // Listen for service updates
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Service Demo'),
      ),
      body: Center(
        child: Text('Count: $_count'),
      ),
    );
  }

  @override
  void dispose() {
    // Stop the background service when the widget is disposed

    super.dispose();
  }
}
