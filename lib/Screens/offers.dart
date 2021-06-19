import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/constants.dart';
import 'package:fit/model/order.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/responsive/screen.dart';
import 'package:fit/services/orders.dart';
import 'package:fit/services/store.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Offers extends StatefulWidget {
  static String id = 'offers';

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  Orders _orders = Orders();
  Store store = Store();
  FirebaseAuth auth = FirebaseAuth.instance;
  String userId;
  int phone;
  String name;
  String address;
  int price;
  String id;
  String comment;

  void getCurrentUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString('userId');
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeCustom>(context);
    return Scaffold(
      backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('MyOrders'),
        backgroundColor: theme.isdark == true ? Colors.teal : ksecondcolor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _orders.fetchingMyOrder(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('You don\'t have any Order'),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.docs) {
              final data = doc.data();
              if (userId == data['orderBy']) {
                orders.add(
                  Order(
                    totlaprice: data['total'],
                    address: data['address'],
                    phonenum: data['phone'],
                    name: data['name'],
                    orderBy: data['orderBy'],
                    comment: data['comment'],
                  ),
                );
              }
            }

            return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: fromRealHeight(15, context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.teal,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 3),
                              blurRadius: 6.0,
                            )
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                    'totalPrice :  ${orders[index].totlaprice}'),
                                SizedBox(
                                  width: 50,
                                ),
                                Text('phone :  ${orders[index].phonenum}'),
                              ],
                            ),
                            Text('name :  ${orders[index].name}'),
                            Text('address :  ${orders[index].address}'),
                            Text('comment :  ${orders[index].comment}'),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
