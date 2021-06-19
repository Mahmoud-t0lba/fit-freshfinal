import 'package:fit/Screens/homepagescreen/homepagescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit/Screens/adminscreens/adminhome.dart';

class NavigaterPage extends StatefulWidget {
  static String id = 'Navigater';
  @override
  _NavigaterPageState createState() => _NavigaterPageState();
}

class _NavigaterPageState extends State<NavigaterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              RaisedButton(
                color: Colors.lightGreen,
                onPressed: () {
                  Navigator.pushNamed(context, HomePageScreen.id);
                },
                child: Text(
                  'GO To USER PAGE',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                color: Colors.lightGreen,
                onPressed: () {
                  Navigator.pushNamed(context, AdminPageHome.id);
                },
                child: Text(
                  'GO To Admin PAGE',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
