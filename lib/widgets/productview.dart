import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/Screens/favorite.dart';
import 'package:fit/Screens/offersdetails.dart';
import 'package:flutter/material.dart';
import 'package:fit/services/store.dart';
import 'package:fit/model/product.dart';
import 'package:fit/constants.dart';
import 'package:fit/widgets/productcard.dart';

final _store = Store();
List<Product> _products = [];
List<Product> favouriteItems = [];
Favourite favourite = Favourite();
Widget productview(String category) {
  return StreamBuilder<QuerySnapshot>(
      stream: _store.editProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc.data();
            products.add(Product(
              pid: doc.id,
              pPrice: data[kProductprice],
              pCategory: data[kproductCategory],
              pDiscribtion: data[kproductDiscribtion],
              pLink: data[kImagelink],
              pName: data[kProductname],
            ));
          }
          _products = [...products];
          products.clear();
          products = getproductcategory(category);
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                width: MediaQuery.of(context).size.width * .62,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OffersINfo.id,
                        arguments: products[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 2, 8),
                    child: ProductCard(
                      url: products[index].pLink,
                      name: products[index].pName,
                      price: products[index].pPrice,
                      fav: null,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Text('Loading .....'),
          );
        }
      });
}

List<Product> getproductcategory(String category) {
  List<Product> products = [];
  try {
    for (var product in _products) {
      if (product.pCategory == category) {
        products.add(product);
      }
    }
  } catch (ex) {
    print(ex);
  }
  return products;
}
