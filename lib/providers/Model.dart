import 'package:flutter/cupertino.dart';

class ModalHud extends ChangeNotifier {
  bool isloading = false;

  changeisloading(value) {
    isloading = value;
    notifyListeners();
  }
}
