import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


class SplashScreen extends StatefulWidget {
  static String id ='splash screen';
  final Widget screen;

  SplashScreen({this.screen});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image(image: AssetImage('assets/images/fit.png',)) ,
splashIconSize: 500,
centered: true,
      nextScreen: widget.screen,
      duration:2,
      backgroundColor: Colors.black87.withRed(20),





    );
  }
}
