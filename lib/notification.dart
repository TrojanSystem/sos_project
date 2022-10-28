import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  Future<void> _messageHandler(RemoteMessage message) async {
    print('background message ${message.notification.body}');
  }

  @override
  void initState() {
    print('started');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      messageTitle = message.notification.title;
      print('Message data: ${message.notification.body}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        setState(() {
          messageTitle = message.notification.title;
          notificationAlert = "New Notification Alert";
        });
      },
    );
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              notificationAlert,
            ),
            Text(
              messageTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
