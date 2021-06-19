import 'package:fit/helper/database_helper.dart';

import 'package:flutter/material.dart';
import 'package:fit/model/product.dart';

class Cartitem extends ChangeNotifier {
  List<Product> prducts = [];

  addproduct(product, productId, c) async {
    await DatabaseHelper().insertProduct(product, prducts, c);

    notifyListeners();
  }

  // ignore: missing_return
  Future<Cartitem> deleteproduct(product) async {
    await DatabaseHelper().deleteProduct(product.pid, prducts);

    notifyListeners();
  }
}
