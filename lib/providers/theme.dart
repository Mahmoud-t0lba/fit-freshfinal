import 'package:flutter/cupertino.dart';

class ThemeCustom extends ChangeNotifier {
  bool isdark = false;

  changeisloading(value) {
    isdark = value;
    notifyListeners();
  }
}
