import 'package:fit/Screens/category_screen.dart';
import 'package:fit/Screens/homepagescreen/homepagescreen.dart';
import 'package:fit/Screens/productinfo.dart';
import 'package:fit/constants.dart';
import 'package:fit/helper/database_helper.dart';
import 'package:fit/responsive/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit/model/product.dart';
import 'package:fit/services/store.dart';
import 'package:fit/providers/cartitem.dart';
import 'package:fit/services/showmenu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fit/providers/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fit/widgets/Emptycart.dart';

class CartScreen extends StatefulWidget {
  static String id = 'cartscreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String notify;
  String userId;

  void getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final uid = preferences.getString('userId');
    userId = uid;
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products =
        Provider.of<Cartitem>(context, listen: false).prducts;
    final theme = Provider.of<ThemeCustom>(context, listen: false);

    return Scaffold(
      backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[700],
        child: Center(
          child: GestureDetector(
            onTap: () {
              showcustomdialog(products, context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.opencart),
                Text(
                  'Order',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico'),
                )
              ],
            ),
          ),
        ),
        onPressed: () {
          print('tapped');
        },
      ),
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeCustom>(context, listen: false).isdark == false
                ? ksecondcolor
                : textmaincolor,
        title: Center(
          child: Text(
            'MyCart'.toUpperCase(),
          ),
        ),
      ),
      body: FutureBuilder(
          initialData: products,
          future: _getData(products),
          builder: (context, snapshot) {
            products = snapshot.data;
            print(snapshot.data);

            if (products.length == 0 || products.length == null) {
              return EmptyCart(theme: theme);
            } else {
              return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    print(products[index].size);
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTapUp: (details) {
                          show(details, context, products[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(20)),
                            height: fromRealHeight(22.5, context),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, ProductInfo.id,
                                        arguments: products[index]);
                                  },
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(products[index].pLink),
                                    radius: MediaQuery.of(context).size.height *
                                        .075,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        products[index].pName,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Row(
                                        children: [
                                          Text(
                                            'TotalPrice :',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontFamily: 'Pacifico'),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Text(
                                              products[index].pPrice,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          ClipOval(
                                            child: GestureDetector(
                                                onTap: () {
                                                  DatabaseHelper()
                                                      .updateProduct(
                                                          products[index]);
                                                  setState(() {
                                                    products[index].pQuantity++;
                                                  });
                                                },
                                                child: Container(
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(Icons.add),
                                                    ))),
                                          ),
                                          Text(
                                            products[index]
                                                .pQuantity
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Pacifico'),
                                          ),
                                          ClipOval(
                                            child: GestureDetector(
                                                onTap: () {
                                                  if (products[index]
                                                          .pQuantity >
                                                      1) {
                                                    DatabaseHelper()
                                                        .updateProduct(
                                                            products[index]);
                                                    setState(() {
                                                      products[index]
                                                          .pQuantity--;
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          Icon(Icons.minimize),
                                                    ))),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ClipOval(
                                      child: Container(
                                        color: Colors.white,
                                        child: Text(products[index].pCategory ==
                                                    'Beef Meals' ||
                                                products[index].pCategory ==
                                                    'SeaFood Meals' ||
                                                products[index].pCategory ==
                                                    'Chicken Meals'
                                            ? products[index].size
                                            : 'pimp your diet'),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }

  Builder ordernowBuilder(List<Product> products) {
    return Builder(
      builder: (context) => ButtonTheme(
          minWidth: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .09,
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: () {
              showcustomdialog(products, context);
            },
            child: Text(
              'Order Now!'.toUpperCase(),
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'Pacifico'),
            ),
            disabledColor: Colors.lightGreen,
            color: Colors.teal,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
          )),
    );
  }

  show(
    details,
    context,
    Product product,
  ) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    List<Product> products =
        Provider.of<Cartitem>(context, listen: false).prducts;
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          Mypopmunuitem(
            child: Text('Delete'),
            onClick: () async {
              await DatabaseHelper().deleteProduct(product.pid, products);

              Navigator.pop(context);

              Navigator.popAndPushNamed(context, CartScreen.id);
            },
          )
        ]);
  }

  void showcustomdialog(List<Product> products, context) async {
    var price = gettotalprice(products);
    String address;
    String name;
    int phone;
    String comment;
    final GlobalKey<FormState> orderformkey = GlobalKey<FormState>();
    AlertDialog alertDialog = AlertDialog(
      actions: [
        FutureBuilder(
            future: _getData(products),
            builder: (context, snapshot) {
              return MaterialButton(
                  onPressed: () async {
                    try {
                      if (orderformkey.currentState.validate()) {
                        Store _store = Store();
                        _store.storeorders({
                          kProductname: name,
                          'phone': phone,
                          'address': address,
                          'total': price,
                          'comment': comment,
                          'orderBy': userId,
                        }, products, userId);

                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "Order Confirmed",
                          desc: "prices didn't include taxes or delivery",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                List<Product> prots = Provider.of<Cartitem>(
                                        context,
                                        listen: false)
                                    .prducts;

                                prots.clear();
                                Navigator.popAndPushNamed(
                                    context, HomePageScreen.id);
                              },
                              width: 120,
                            )
                          ],
                        ).show();

                        products.clear();
                        String id = 'a';

                        for (Product p in snapshot.data) {
                          id = p.pid;
                        }

                        await DatabaseHelper().deleteProduct(id, products);

                        dispose();
                      } else if (price == 0 || price == null) {
                        Navigator.popAndPushNamed(context, Category.id);
                      } else {
                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Complet required data')));
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Order'));
            })
      ],
      title: Text('Total Price is $price'),
      content: SingleChildScrollView(
        child: Form(
          key: orderformkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Invalid Input';
                    else
                      return null;
                  },
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(hintText: 'Enter Your name'),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Enter Your phone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value.length < 11 || value.length > 11) {
                      return 'Invalid phone Number';
                    } else if (value.isEmpty ||
                        value.length < 11 ||
                        value.length > 11 ||
                        value.characters.first != 0.toString() ||
                        value.characters.elementAt(1) != 1.toString()) {
                      return "Please Enter Phone";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    phone = int.parse(value);
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Invalid Input';
                    else
                      return null;
                  },
                  onChanged: (value) {
                    address = value;
                  },
                  decoration: InputDecoration(hintText: 'Enter Your Address'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty)
                      return null;
                    else
                      return null;
                  },
                  onChanged: (value) {
                    comment = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'tell us if you have comment on order'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  gettotalprice(List<Product> products) {
    int price = 0;

    for (var prduct in products) {
      price += int.parse(prduct.pPrice) * prduct.pQuantity;
    }
    return price;
  }

  Future<List<Product>> _getData(List<Product> p) async {
    await DatabaseHelper()
        .getAllProduct(p)
        .then((value) => {print(value), p = value});
    return p;
  }
}
