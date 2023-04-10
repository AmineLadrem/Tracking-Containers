// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDRVttUrP4dpKej3vmFUVqPQB648yE6OlY',
    appId: '1:240023193465:web:7acabaee39bec0f22bd1a8',
    messagingSenderId: '240023193465',
    projectId: 'tracking-rtdb',
    authDomain: 'tracking-rtdb.firebaseapp.com',
    databaseURL: 'https://tracking-rtdb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'tracking-rtdb.appspot.com',
    measurementId: 'G-2TY7GM6P07',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyshJ8naXFPAaldwBRijj8zu31igEzR_A',
    appId: '1:240023193465:android:ee99d8a5aae916ad2bd1a8',
    messagingSenderId: '240023193465',
    projectId: 'tracking-rtdb',
    databaseURL: 'https://tracking-rtdb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'tracking-rtdb.appspot.com',
  );
}
