import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class NotificationMessaging extends StatefulWidget {
  @override
  _NotificationMessagingState createState() => _NotificationMessagingState();
}

class _NotificationMessagingState extends State<NotificationMessaging> {
  final FirebaseMessaging  _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    /// method notifications callback
    configureCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void configureCallbacks(){
     _firebaseMessaging.configure(
       onMessage: (Map<String, dynamic> message) async {
         print('this is message $message');
       }
     );
  }


}
