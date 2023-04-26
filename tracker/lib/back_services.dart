import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

var device;
Future<void> initializeSerive() async {
  LocationPermission permission;
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
  String deviceName = androidInfo.id;
  device = deviceName.substring(12);
  print(device);
  final service = FlutterBackgroundService();
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permissions are denied');
    }
  }
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStart: true));
}

@pragma('vm:entry-point')
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
  String deviceName = androidInfo.id;
  device = deviceName.substring(12);
  Timer.periodic(Duration(seconds: 1), (timer) async {
    Position position = await Geolocator.getCurrentPosition();
    print('Location update: ${position.latitude}, ${position.longitude}');
    String data =
        "{\"latitude\":${position.latitude},\"longitude\":${position.longitude}}";

    String url =
        'https://tracking-rtdb-default-rtdb.europe-west1.firebasedatabase.app/$device/.json?auth=404QxLl3TtXI6V1eMIb6vbdfvGtMKFCur4COwvzH';
    http.Response response = await http.patch(Uri.parse(url), body: data);
    print('Response status: ${response.statusCode}');
  });
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // Request for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }
  }
}
