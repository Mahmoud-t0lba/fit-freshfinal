import 'package:fit/Screens/productinfo.dart';

import 'package:fit/providers/favorite.dart';
import 'package:fit/services/store.dart';
import 'package:fit/widgets/custom_cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit/constants.dart';
import 'package:fit/providers/theme.dart';

class Favourtie extends StatefulWidget {
  static String id = 'fav';

  @override
  _FavourtieState createState() => _FavourtieState();
}

class _FavourtieState extends State<Favourtie> {
  // ignore: unused_field
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeCustom>(context);
    final products = Provider.of<Favorite>(context).favorite;
    return Scaffold(
      backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
      appBar: AppBar(
        backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
        title: Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
          child: Row(
            children: [
              Center(
                child: Text(
                  'Favourites',
                  style: TextStyle(
                      fontSize: 22.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pacifico',
                      color: Provider.of<ThemeCustom>(context).isdark == false
                          ? secondtextcolor
                          : textmaincolor),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.favorite,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .65,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProductInfo.id,
                    arguments: products[index]);
              },
              child: CustomCartItem(
                image: products[index].pLink,
                product: products[index],
                name: products[index].pName,
                calories: products[index].cal,
                price: products[index].pPrice,
              ),
            ),
          );
        },
      ),
    );
  }
}
