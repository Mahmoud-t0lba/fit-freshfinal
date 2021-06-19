import 'dart:convert';
import 'package:fit/model/product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget fav;

class Favourite extends StatefulWidget {
 final Product product;

 final List<Product> products;
  final List<Product> favourite;

  Favourite({this.product, this.products, this.favourite});

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  savePref(List<Product> favlist) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<Map<dynamic,dynamic>> _convertedFavourite = [];
    favlist.add(widget.product);
   favlist.forEach((element)=> _convertedFavourite.add(element.toJson())
    );
    preferences.setString('Favourite', jsonEncode(_convertedFavourite) );
    print(jsonDecode(preferences.get('Favourite')));
  }

  @override
  Widget build(BuildContext context) {
     Icon(
            Icons.favorite,
            color: Colors.red,
          )
       ;
    return GestureDetector(
        onTap: () {
          addfavourite();
        },
        onDoubleTap: () {
          remove();
        },
        child: fav);
  }

  List<Product> addfavourite() {
    bool exist = false;
    for (Product i in widget.products) {
      if (i == widget.product) {
        exist = true;
      }
    }
    if (exist == true) {
      widget.favourite.add(widget.product);
      savePref(widget.favourite);
      setState(() {
        fav = Icon(
          Icons.favorite,
          color: Colors.red,
        );
      });
    }
    return widget.favourite;
  }

  List<Product> remove() {
    for (var i in widget.favourite) {
      if (i == widget.product) {
        widget.favourite.remove(widget.product);
        savePref(widget.favourite);
        setState(() {
          fav = Icon(
            Icons.favorite_border,
          );
        });
        return widget.favourite;
      }
    }
    return widget.favourite;
  }
}
