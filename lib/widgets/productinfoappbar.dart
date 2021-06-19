import 'package:badges/badges.dart';
import 'package:fit/Screens/cartscreen.dart';
import 'package:fit/helper/database_helper.dart';
import 'package:fit/model/product.dart';
import 'package:fit/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';


class Appbarcustom extends StatelessWidget {
  const Appbarcustom({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;


  @override

  Widget build(BuildContext context) {
    var c;
    return FutureBuilder(future: _getData(c),builder: (context,snapshot)
    {c =snapshot.data;
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 15, 13, 0),
        child: GestureDetector(onTap: (){Navigator.pushNamed(context, CartScreen.id);},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,children: [
            c==0
                ? Icon(Icons.shopping_cart,color: Provider.of<ThemeCustom>(context).isdark == false
                ? secondtextcolor
                : textmaincolor,)
                : Badge(
              badgeContent: Text(
                '${snapshot.hasData?c.toString():0}',
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(
                Icons.shopping_cart,
                color: Provider.of<ThemeCustom>(context).isdark == false
                    ? secondtextcolor
                    : textmaincolor,
              ),
            ),

          ],),
        ),
      );
    });
  }



}
Future<int>_getData(var c)async {
  await DatabaseHelper().getAllProductlenght(c).then((value) => {
    print(value),

   c =value
  });
  return c;
}
