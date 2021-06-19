import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Screen {
  static const MethodChannel _channel = const MethodChannel('screen');
  static Future<dynamic> get getScreen async {
    final dynamic version = await _channel.invokeMethod('getScreen');
    return version.toString();
  }
}

/// A Calculator.

double fromRealHeight(double nsba, BuildContext context) {
  return MediaQuery.of(context).size.height * nsba / 100;
}

double fromRealWidth(double nsba, BuildContext context) {
  return MediaQuery.of(context).size.width * nsba / 100;
}

// fromSize(double nsba,BuildContext context){
//   double max;
//   if(isLandSpace(context)){
//      max = MediaQuery.of(context).size.aspectRatio * nsba / 3.0;
//   }else{
//     max = MediaQuery.of(context).size.aspectRatio * nsba;
//   }
//   return max;
// }

fromSize(double nsba, BuildContext context) {
  double max;
  if (MediaQuery.of(context).size.height > MediaQuery.of(context).size.width) {
    max = MediaQuery.of(context).size.height /
        MediaQuery.of(context).size.width *
        nsba /
        3.5;
  } else {
    max = MediaQuery.of(context).size.width /
        MediaQuery.of(context).size.height *
        nsba /
        3.5;
  }
  return max;
}

bool isKeyboardOpened(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom > 0.0;
}

bool isLandScape(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.landscape;
}

// odd thomas