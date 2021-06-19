import 'package:flutter/material.dart';

class BackGroundImage  extends StatelessWidget {
 final Widget child;
  BackGroundImage({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
    height: MediaQuery.of(context).size.height,
width: MediaQuery.of(context).size.width,
decoration: BoxDecoration(
image: DecorationImage(
image: AssetImage('assets/images/photo_2020-11-08_17-54-31.jpg'),
fit: BoxFit.fill,
)),
      child: child,
    );
  }
}
