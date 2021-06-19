import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/Screens/adminscreens/editdetails.dart';
import 'package:flutter/material.dart';
import 'package:fit/services/store.dart';
import 'package:fit/model/product.dart';
import 'package:fit/constants.dart';

class EditProductPage extends StatelessWidget {
  static String id = 'Edit Product';
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
            stream: _store.editProducts(),
            builder: (
              context,
              snapshot,
            ) {
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
                      pName: data[kProductname]));

                  if (doc.data().containsValue(data[kProductname])) {
                    print(data[kProductname]);
                  }
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: .8),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTapUp: (details) {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width - dx;
                        double dy2 = MediaQuery.of(context).size.width - dy;
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items: [
                              Mypopmunuitem(
                                child: Text('Edit'),
                                onClick: () {
                                  Navigator.pushNamed(context, EditDetails.id,
                                      arguments: products[index]);
                                },
                              ),
                              Mypopmunuitem(
                                child: Text('Delete'),
                                onClick: () {
                                  if (products[index].pCategory ==
                                          'Beef Meals' ||
                                      products[index].pCategory ==
                                          'Chicken Meals' ||
                                      products[index].pCategory ==
                                          'SeaFood Meals') {
                                    for (var p in products) {
                                      if (p.pName == products[index].pName) {
                                        _store
                                            .deleteproduct(products[index].pid);
                                        _store.deleteproduct(p.pid);
                                      } else {
                                        _store
                                            .deleteproduct(products[index].pid);
                                      }
                                    }
                                  } else {
                                    _store.deleteproduct(products[index].pid);
                                  }
                                },
                              )
                            ]);
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(products[index].pLink))),
                          Positioned(
                              bottom: 0,
                              child: Opacity(
                                  opacity: .7,
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            products[index].pName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            products[index].pPrice,
                                          )
                                        ],
                                      ),
                                    ),
                                  )))
                        ],
                      ),
                    ),
                  ),
                  itemCount: products.length,
                );
              } else {
                return Center(
                  child: Text('Loading .....'),
                );
              }
            }));
  }
}

class Mypopmunuitem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  Mypopmunuitem({@required this.child, this.onClick}) : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MypopmunuitemState();
  }
}

class MypopmunuitemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, Mypopmunuitem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
