import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void requestNotificationPermission() async {}
  Future<String> getDeviceTocken() async {
   String? tocken = await messaging.getToken();
    return tocken!;
  }
}
