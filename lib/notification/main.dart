import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:camera_app/notification/api/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseApi firebaseApi = FirebaseApi();

  MyApp() {
    firebaseApi.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firebase Notifications Example'),
        ),
        body: Center(
          child: Text('Welcome to the App'),
        ),
      ),
    );
  }
}
