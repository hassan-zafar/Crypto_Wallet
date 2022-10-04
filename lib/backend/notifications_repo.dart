import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../helpers/strings.dart';


abstract class BaseNotifications {
  getnStoreToken(Function(String)? userStoreToken);
  subscribeToTopics();
  unSubscribeToTopics();
  streamEvents();
  backgroundMsg();
  requestPermission();
}

class NotificationsRepo implements BaseNotifications {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // var userBx = Hive.box(SETTINGS);

  Future<void> _messageHandler(RemoteMessage message) async {
    // userBx.put(NOTIFICATION, true);
  }

  @override
  getnStoreToken(Function(String)? userStoreToken) async {
    String? token = await messaging.getToken();

    // Save the initial token to the database
    userStoreToken!(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(userStoreToken);
  }

  @override
  subscribeToTopics() {
    messaging.subscribeToTopic('price-alert');
    messaging.subscribeToTopic('admin-message');
  }

  @override
  unSubscribeToTopics() {
    messaging.unsubscribeFromTopic('price-alert');
    messaging.unsubscribeFromTopic('admin-message');
  }

  @override
  streamEvents() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      // userBx.put(NOTIFICATION, true);
    });
  }

  @override
  backgroundMsg() {
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }

  @override
  requestPermission() async {
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    } catch (e) {
      print(e);
    }
  }
}
