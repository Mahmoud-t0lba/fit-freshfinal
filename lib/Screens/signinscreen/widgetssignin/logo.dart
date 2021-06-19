import 'package:flutter/material.dart';
class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width*.8,
        height: MediaQuery.of(context).size.height * .25,
        child: Image.asset('assets/images/fit.png',));
  }
}
