import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fit/launchsocial.dart';
import 'package:fit/constants.dart';
import 'package:fit/providers/theme.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatelessWidget {
  static String id = 'aboutus';
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeCustom>(context);
    return Scaffold(
      backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('assets/images/team.jpg'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 10,
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
                SizedBox(width: 1),
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      launchURLF();
                    },
                    child: Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                      size: 40,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
