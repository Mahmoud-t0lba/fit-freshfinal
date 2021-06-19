import 'package:fit/Screens/adminscreens/orderdetails.dart';
import 'package:fit/constants.dart';
import 'package:fit/model/order.dart';
import 'package:fit/services/orders.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VeiwOrdersPage extends StatelessWidget {
  static String id = 'ViewOrders';
  final Orders _order = Orders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text('ORDERS'),
      ),
      backgroundColor: kmaincolor,
      body: StreamBuilder<QuerySnapshot>(
        stream: _order.fetchingAllOrder(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('This no orders'),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.docs) {
              final data = doc.data();
              orders.add(Order(
                docid: doc.id,
                address: data['address'],
                name: data['name'],
                phonenum: data['phone'],
                totlaprice: data['total'],
              ));
            }
            return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, OrderDetails.id,
                              arguments: orders[index].docid);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green.withOpacity(0.5),
                            ),
                            height: MediaQuery.of(context).size.height * 0.23,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Name : ${orders[index].name}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              ' TotalPrice : ${orders[index].totlaprice}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        ' PhoneNumber : ${orders[index].phonenum}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          ' Address : ${orders[index].address}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        // ignore: deprecated_member_use
                                        child: FlatButton(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          onPressed: () {
                                            print('working');
                                          },
                                          child: Text(
                                            'DONE',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
          }
        },
      ),
    );
  }
}
