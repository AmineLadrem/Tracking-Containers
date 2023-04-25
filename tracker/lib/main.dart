import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Start the background service
  FlutterBackgroundService().startService();
  runApp(MyApp());
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

  void onStart() async {
    // Check if the service is already running
    bool isRunning = await FlutterBackgroundService().isRunning();
    if (!isRunning) {
      // Start the timer when the background service is started
      Timer.periodic(Duration(seconds: 5), (timer) {
        print('Hello from background service!');
        // Update the service status
      });
    }
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
