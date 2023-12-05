import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Function to initialize notification
  Future<void> initNotifications() async {
    // Request permission from the user (will prompt user)
    await _firebaseMessaging.requestPermission();

    // Fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();

    // Print the token
    print("FCM Token: $fCMToken");

    // Configure the onMessage callback to handle incoming messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground Message Received: ${message.notification?.body}");
      // Handle the FCM message in the foreground
      _handleForegroundMessage(message);
    });

    // Configure the onBackgroundMessage callback to handle incoming messages when the app is in the background
 
  }

  // Function to handle received messages in the foreground
  void _handleForegroundMessage(RemoteMessage message) {
    // Your logic to handle foreground messages goes here
    // For example, show a notification
    _showNotification(message);
  }

  // Function to handle received messages in the background
  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print("Background Message Received: ${message.notification?.body}");
    // Your logic to handle background messages goes here
    // For example, show a notification
    _showNotification(message);
  }

  // Function to show a notification
  void _showNotification(RemoteMessage message) {
    // Your logic to show a notification goes here
    // You can use a third-party package like flutter_local_notifications
  }
}
