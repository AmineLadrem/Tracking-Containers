import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracker/back_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permissions are denied');
    }
  }
  await Permission.notification.isDenied.then((value) async {
    if (value) {
      await Permission.notification.request();
    }
  });
  await initializeSerive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Background Service Demo',
        home: Scaffold(
            body: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Start Foregrond Service'),
              onPressed: () {
                FlutterBackgroundService().invoke('setAsForeground');
              },
            ),
            ElevatedButton(
              child: Text('Start Background Service'),
              onPressed: () {
                FlutterBackgroundService().invoke('setAsBackground');
              },
            ),
            ElevatedButton(
              child: Text('Stop'),
              onPressed: () async {
                final service = FlutterBackgroundService();
                bool isRunning = await service.isRunning();
                if (isRunning) {
                  service.invoke('stopService');
                } else {
                  service.startService();
                }
              },
            ),
          ],
        ))));
  }
}
