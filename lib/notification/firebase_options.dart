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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyCJH1oPgGEsfFF7c5mY5GEaSBNbZ0YwVBQ',
    appId: '1:116059274381:web:3943624991354caeb2f6c4',
    messagingSenderId: '116059274381',
    projectId: 'joinnotifications',
    authDomain: 'joinnotifications.firebaseapp.com',
    storageBucket: 'joinnotifications.appspot.com',
    measurementId: 'G-HRJ140EEXE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAH_HcSOo9OgRXHtal3z1ebk7mRyHWaBxs',
    appId: '1:116059274381:android:b3648857d81e872eb2f6c4',
    messagingSenderId: '116059274381',
    projectId: 'joinnotifications',
    storageBucket: 'joinnotifications.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCovvuoFAqAYZaiCxfXhwyN6axQ4uetQ5Q',
    appId: '1:116059274381:ios:1b7291ea654dfb8bb2f6c4',
    messagingSenderId: '116059274381',
    projectId: 'joinnotifications',
    storageBucket: 'joinnotifications.appspot.com',
    iosBundleId: 'com.example.cameraApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCovvuoFAqAYZaiCxfXhwyN6axQ4uetQ5Q',
    appId: '1:116059274381:ios:c32bde22cbae51b6b2f6c4',
    messagingSenderId: '116059274381',
    projectId: 'joinnotifications',
    storageBucket: 'joinnotifications.appspot.com',
    iosBundleId: 'com.example.cameraApp.RunnerTests',
  );
}
