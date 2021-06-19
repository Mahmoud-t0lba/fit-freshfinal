import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fit/launchsocial.dart';

class VisitUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Visit Us',
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                launchURLI();
              },
              child: Icon(
                FontAwesomeIcons.instagram,
                color: Colors.red,
                size: 40,
              ),
            ),
            SizedBox(
              width: 1,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                launchURLF();
              },
              child: Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
