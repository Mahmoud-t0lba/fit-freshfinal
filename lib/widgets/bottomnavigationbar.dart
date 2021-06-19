import 'package:badges/badges.dart';
import 'package:fit/Screens/cartscreen.dart';
import 'package:fit/Screens/category_screen.dart';
import 'package:fit/Screens/favouritesscreen.dart';
import 'package:fit/Screens/homepagescreen/homepagescreen.dart';
import 'package:fit/helper/database_helper.dart';
import 'package:fit/model/product.dart';
import 'package:fit/providers/cartitem.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:fit/providers/theme.dart';

class CurvedBottom extends StatefulWidget {
  @override
  _CurvedBottomState createState() => _CurvedBottomState();
}

class _CurvedBottomState extends State<CurvedBottom> {
  int index = 1;
  List<String> screens = [
    HomePageScreen.id,
    Category.id,
    Favourtie.id,
    CartScreen.id,
  ];
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List<Product> products = Provider.of<Cartitem>(context).prducts;
    var c;
    return FutureBuilder(
        future: _getData(c),
        builder: (context, snapshot) {
          c = snapshot.data;
          return CurvedNavigationBar(
            index: index,
            onTap: (index) async {
              setState(() {
                index = index;
              });
              if (index == 0) {
                Navigator.pushNamed(context, screens[1]);
              } else if (index == 1) {
                Navigator.popAndPushNamed(context, screens[0]);
              } else {
                Navigator.pushNamed(context, screens[index]);
              }
            },
            height: MediaQuery.of(context).size.height * .075,
            backgroundColor: Colors.white,
            items: [
              Icon(Icons.category, color: Colors.white),
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.favorite, color: Colors.white),
              snapshot.hasData == false
                  ? Badge(
                      badgeContent: Text(
                        '${0}',
                        style: TextStyle(color: Colors.white),
                      ),
                      child: Icon(Icons.shopping_cart, color: Colors.white))
                  : Badge(
                      badgeContent: Text(
                        '${c.toString()}',
                        style: TextStyle(color: Colors.white),
                      ),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
            ],
            buttonBackgroundColor:
                Provider.of<ThemeCustom>(context).isdark == true
                    ? Colors.green[700]
                    : Colors.grey,
            color: Provider.of<ThemeCustom>(context).isdark == true
                ? Colors.green[700]
                : Colors.black,
            animationCurve: Curves.easeInOut,
          );
        });
  }

  Future<int> _getData(var c) async {
    await DatabaseHelper()
        .getAllProductlenght(c)
        .then((value) => {print(value), c = value});
    return c;
  }
}
