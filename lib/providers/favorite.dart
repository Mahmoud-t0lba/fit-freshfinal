import 'dart:convert';

import 'package:fit/model/product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends ChangeNotifier {

  List<Product> favorite = [];
  SharedPreferences sharedPreferences;


  Favorite(){
    loadSharedPreferencesAndData();
  }



  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadingData();
  }

  void savingData() {
    List<String> listString =
        favorite.map((e) => jsonEncode(e.toJson())).toList();
    // print(listString);
    sharedPreferences.setStringList('list', listString);
  }

  void loadingData() {
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      favorite =
          listString.map((e) => Product.fromJson(jsonDecode(e))).toList();
      notifyListeners();
    }
  }



  void addingFavorite(productItem) {
    favorite.add(productItem);
    savingData();
    notifyListeners();
  }

  void deletingFavorite(productItem) {
    // favorite.removeWhere(productItem);
    favorite.removeWhere((element) => element.pid == productItem);
    savingData();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

}
