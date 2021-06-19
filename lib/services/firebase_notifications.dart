import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FirebaseNotifications {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future getFCM() async {
    String fcm;
    await _firebaseMessaging.getToken().then((value) => fcm = value);
    return fcm;
  }
  final String _webApi = 'AAAAcnuZUIE:APA91bEMkzHpFAHZUKarB5RCjfU4sFJ668QYwxJI3gF0pOh9h__ABc0jLcEDQ30JxRNBaiDyDJlG_tnxf-ad1QKLpQKy79hhMgk4eEo6wawY44Iu-7uPjB1lbVOme3ud7oEVeKtYW1y8';
  Future<Map<String, dynamic>> pushNotification(String fcm) async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    try{
      await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$_webApi',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'this is a body',
              'title': 'this is a title'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': fcm,
          },
        ),
      );
    }catch(e){print(e);}

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
    return completer.future;
  }
}
