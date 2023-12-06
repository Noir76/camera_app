import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'history_page.dart';

List<CameraDescription> cameras = [];

class CameraApp extends StatefulWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  int selectedCameraIndex = 0;
  late Future<void> _initializeControllerFuture;
  List<HistoryItem> historyList = [];

  @override
  void initState() {
    super.initState();

    availableCameras().then((List<CameraDescription> availableCameras) {
      cameras = availableCameras;

      if (cameras.isNotEmpty) {
        _initializeCamera();
      } else {
        print('No cameras available');
      }
    });

    _initializeControllerFuture = Future.delayed(Duration.zero);
  }

  void _initializeCamera() {
    controller = CameraController(cameras[selectedCameraIndex], ResolutionPreset.medium);
    _initializeControllerFuture = controller.initialize();
  }

  Future<String> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return '${placemark.street}, ${placemark.locality}, ${placemark.country}';
      } else {
        return 'No address found';
      }
    } catch (e) {
      return 'Error getting location: $e';
    }
  }

  void switchCamera() {
    final newCameraIndex = selectedCameraIndex == 0 ? 1 : 0;

    controller.dispose().then((_) {
      setState(() {
        selectedCameraIndex = newCameraIndex;
        _initializeCamera();
      });
    });
  }

  Future<void> _onPictureTaken() async {
      try {
          await _initializeControllerFuture;
          final image = await controller.takePicture();

          if (!mounted) return;

          final location = await _getCurrentLocation();

          print('Picture taken at: ${image.path}');
          print('Location: $location');

          final historyItem = HistoryItem(imagePath: image.path, locationInfo: location);

          await _sendHistoryItemData(historyItem);

          setState(() {
            historyList.add(historyItem);
          });
        } catch (e) {
          print('Error taking picture: $e');
        }
  }

  Future<void> _sendHistoryItemData(HistoryItem historyItem) async {
    final url = Uri.parse('http://10.0.2.2:8000/image/upload');
  
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // body: historyItem.toJson(),
      body: jsonEncode({
        "imagePath": historyItem.imagePath,
        "locationInfo": historyItem.locationInfo
      }),
    );

    if (response.statusCode == 200) {
      print('History item added successfully');
    } else {
      print('Failed to add history item: ${response.statusCode}');
    }
 
}

  Future<void> navigateToHistoryPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryPage()),
    );


  }

  Widget _toolbar()
  {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: switchCamera ,
            child: const Icon(Icons.switch_camera),
              ),
          RawMaterialButton(
            onPressed: _onPictureTaken,
            child: const Icon(Icons.camera_alt),
              ), // Icon
        ]
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera App')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _toolbar(),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => navigateToHistoryPage(context),
            child: const Icon(Icons.history),
          ),
        ],
      ),
    );
  }
}

