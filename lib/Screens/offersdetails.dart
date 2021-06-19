import 'package:fit/providers/cartitem.dart';
import 'package:flutter/material.dart';
import 'package:fit/constants.dart';
import 'package:provider/provider.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/Screens/cartscreen.dart';
import 'package:badges/badges.dart';
import 'package:fit/model/product.dart';

class OffersINfo extends StatefulWidget {
  static String id = 'offersdetails';
  @override
  _OffersINfoState createState() => _OffersINfoState();
}

class _OffersINfoState extends State<OffersINfo> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    List<Product> products = Provider.of<Cartitem>(context).prducts;
    final theme = Provider.of<ThemeCustom>(context);
    GlobalKey<ScaffoldState> _scafffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scafffoldKey,
      backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeCustom>(context).isdark == false
            ? ksecondcolor
            : kmaincolor,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 15, 13, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CartScreen.id);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  products.length == 0
                      ? Icon(
                          Icons.shopping_cart,
                          color:
                              Provider.of<ThemeCustom>(context).isdark == false
                                  ? secondtextcolor
                                  : textmaincolor,
                        )
                      : Badge(
                          badgeContent: Text(
                            '${products.length}',
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width * .95,
                  child: Padding(
                    padding: const EdgeInsets.all(12.5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          product.pLink,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.pDiscribtion,
                        style: TextStyle(
                            color: Provider.of<ThemeCustom>(context).isdark ==
                                    false
                                ? secondtextcolor
                                : textmaincolor,
                            fontSize: 18),
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.start,
                        maxLines: 20,
                      ),
                    ),
                  ],
                ),
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
                          color:
                              Provider.of<ThemeCustom>(context).isdark == false
                                  ? secondtextcolor
                                  : textmaincolor,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(
                        color: Provider.of<ThemeCustom>(context).isdark == false
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
                          color:
                              Provider.of<ThemeCustom>(context).isdark == false
                                  ? secondtextcolor
                                  : textmaincolor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          Text(product.pPrice,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Provider.of<ThemeCustom>(context)
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
                                color:
                                    Provider.of<ThemeCustom>(context).isdark ==
                                            false
                                        ? secondtextcolor
                                        : textmaincolor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Cartitem cartItem =
                            Provider.of<Cartitem>(context, listen: false);
                        product.pQuantity = quantity;
                        bool exist = false;
                        for (var productInCart in cartItem.prducts) {
                          if (productInCart.pid == product.pid) {
                            exist = true;
                          }
                        }
                        if (exist) {
                          // ignore: deprecated_member_use
                          _scafffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                'you\'ve added this product in cart item.',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (exist == false) {
                          if (product.pCategory == 'Beef Meals' ||
                              product.pCategory == 'Chicken Meals' ||
                              product.pCategory == 'SeaFood Meals') {
                            if (product.side1 == null ||
                                product.side2 == null) {
                              // ignore: deprecated_member_use
                              _scafffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text('Please Choose Sides'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              cartItem.addproduct(
                                product,
                                product.pid,
                                // ignore: deprecated_member_use
                                _scafffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('This item was Added to cart'),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              );
                              // ignore: deprecated_member_use
                              _scafffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text('This item was Added to cart'),
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
                              // ignore: deprecated_member_use
                              _scafffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text('This item was Added to cart'),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            );
                            // ignore: deprecated_member_use
                            _scafffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('This item was Added to cart'),
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
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: Row(
                              children: [
                                Text(
                                  'Add to cart',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 3),
                                Container(
                                  height: 25,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
