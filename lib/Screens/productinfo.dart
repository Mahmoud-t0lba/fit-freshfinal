import 'package:fit/helper/database_helper.dart';
import 'package:fit/providers/cartitem.dart';
import 'package:fit/responsive/screen.dart';
import 'package:fit/widgets/nameinfo.dart';
import 'package:fit/widgets/nutration.dart';
import 'package:fit/widgets/productinfoappbar.dart';
import 'package:fit/widgets/ptoductinfoimage.dart';
import 'package:fit/widgets/showratingbar.dart';
import 'package:fit/widgets/sides.dart';
import 'package:flutter/material.dart';
import 'package:fit/model/product.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fit/constants.dart';
import 'package:fit/providers/theme.dart';

String carts = 'Add to Cart';
String added = 'Add to Cart';
Color color = Colors.black;
int quantity = 1;

class ProductInfo extends StatefulWidget {
  static String id = 'info';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final theme = Provider.of<ThemeCustom>(context);
    List<Product> products = Provider.of<Cartitem>(context).prducts;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
        appBar: AppBar(
          backgroundColor: Provider.of<ThemeCustom>(context).isdark == false
              ? ksecondcolor
              : kmaincolor,
          actions: [
            Appbarcustom(products: products),
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                imageinfo(context, product.pLink),
                nameinfo(product, context),
                SizedBox(
                  height: 15,
                ),
                fristnutration(product, context),
                SizedBox(
                  height: 10,
                ),
                secondnutration(product, context),
                SizedBox(
                  height: 20,
                ),
                product.pCategory == 'Beef Meals' ||
                        product.pCategory == 'Chicken Meals' ||
                        product.pCategory == 'SeaFood Meals'
                    ? ClipOval(
                        child: Container(
                        color: Colors.green[800],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.size,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ))
                    : SizedBox(
                        height: 1,
                      ),
                ratingbar(context),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Expanded(
                    child: Text(
                      product.pDiscribtion,
                      style: TextStyle(
                          color:
                              Provider.of<ThemeCustom>(context).isdark == false
                                  ? secondtextcolor
                                  : textmaincolor,
                          fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                product.pCategory == 'Beef Meals'
                    ? Sises(product: product)
                    : SizedBox(
                        height: 1,
                      ),
                product.pCategory == 'Chicken Meals'
                    ? Sises(product: product)
                    : SizedBox(
                        height: 1,
                      ),
                product.pCategory == 'SeaFood Meals'
                    ? Sises(product: product)
                    : SizedBox(
                        height: fromRealHeight(20, context),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            ' Price',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color:
                                    Provider.of<ThemeCustom>(context).isdark ==
                                            false
                                        ? secondtextcolor
                                        : textmaincolor),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Material(
                              color: Colors.lightGreen.withOpacity(.4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity > 0) {
                                      quantity--;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Provider.of<ThemeCustom>(context)
                                              .isdark ==
                                          false
                                      ? secondtextcolor
                                      : textmaincolor,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                                color:
                                    Provider.of<ThemeCustom>(context).isdark ==
                                            false
                                        ? secondtextcolor
                                        : textmaincolor,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                          ClipOval(
                            child: Material(
                              color: Colors.lightGreen.withOpacity(.4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Provider.of<ThemeCustom>(context)
                                              .isdark ==
                                          false
                                      ? secondtextcolor
                                      : textmaincolor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.lightGreen.withOpacity(.4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      product.pPrice == null
                                          ? product.pPrice = product.price2
                                          : product.pPrice,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Provider.of<ThemeCustom>(context)
                                                          .isdark ==
                                                      false
                                                  ? secondtextcolor
                                                  : textmaincolor)),
                                  SizedBox(
                                    width: 3.5,
                                  ),
                                  Text(
                                    'L.E',
                                    style: TextStyle(
                                        color: Provider.of<ThemeCustom>(context)
                                                    .isdark ==
                                                false
                                            ? secondtextcolor
                                            : textmaincolor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            FutureBuilder(
                                future: _getData(products),
                                builder: (context, snapshot) {
                                  return GestureDetector(
                                    onTap: () async {
                                      Cartitem cartItem = Provider.of<Cartitem>(
                                          context,
                                          listen: false);
                                      product.pQuantity = quantity;

                                      bool exist = false;
                                      bool m = false;

                                      for (var productInCart in snapshot.data) {
                                        productInCart.pid == product.pid
                                            ? exist = true
                                            : exist = false;
                                      }

                                      if (exist == true || m == true) {
                                        _scaffoldKey.currentState
                                            // ignore: deprecated_member_use
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'you\'ve added this product in cart item.'),
                                          ),
                                        );
                                      } else if (exist == false && m == false) {
                                        if (product.pCategory == 'Beef Meals' ||
                                            product.pCategory ==
                                                'Chicken Meals' ||
                                            product.pCategory ==
                                                'SeaFood Meals') {
                                          if (product.side1 == null ||
                                              product.side2 == null) {
                                            _scaffoldKey.currentState
                                                // ignore: deprecated_member_use
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text('Please Choose Sides'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          } else {
                                            await cartItem.addproduct(
                                              product,
                                              product.pid,
                                              _scaffoldKey.currentState
                                                  // ignore: deprecated_member_use
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'This item was Added to cart'),
                                                ),
                                              ),
                                            );

                                            print(product.size);
                                            _scaffoldKey.currentState
                                                // ignore: deprecated_member_use
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'This item was Added to cart'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                            setState(() {
                                              quantity = 1;
                                            });
                                          }
                                        } else {
                                          cartItem.addproduct(
                                              product,
                                              product.pid,
                                              _scaffoldKey.currentState
                                                  // ignore: deprecated_member_use
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'This item was Added to cart'),
                                                backgroundColor: Colors.red,
                                              )));
                                          _scaffoldKey.currentState
                                              // ignore: deprecated_member_use
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'This item was Added to cart'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );

                                          setState(() {
                                            quantity = 1;
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 38,
                                      width: 125,
                                      decoration: BoxDecoration(
                                          color: color,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(left: 9),
                                        child: Row(
                                          children: [
                                            Text(
                                              carts,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              child: Center(
                                                  child: Icon(
                                                Icons.add_shopping_cart,
                                              )),
                                            )
                                          ],
                                        ),
                                      )),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

/* _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
          title: new Text("Cupertino Dialog"),
          content: new Text("Hey! I'm Coflutter!"),
          actions: <Widget>[
            FlatButton(
              child: Text('Close me!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }*/

}

Future<List<Product>> _getData(List<Product> p) async {
  await DatabaseHelper()
      .getAllProduct(p)
      .then((value) => {print(value), p = value});
  return p;
}
