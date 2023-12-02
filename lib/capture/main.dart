import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera.dart'; // Import your CameraApp widget


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
    // capture function
       home: CameraApp(),
    ),
  );
}
