import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/model/product.dart';
import 'package:fit/services/orders.dart';
import 'package:flutter/material.dart';


class OrderDetails extends StatelessWidget {
  static String id = 'orderdetails';
 final Orders _order = Orders();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _order.fetchingOrderDetails(documentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var i in snapshot.data.docs) {
                final data = i.data();
                products.add(
                  Product(
                    pName: data['name'],
                    pPrice: data['price'],
                    pQuantity: data['Quantity'],
                    pLink: data['link'],
                    orderTime: data['orderTime'].toDate(),
                  ),
                );
              }
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green.withOpacity(.5),
                        ),
                        height: MediaQuery.of(context).size.height * .43,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: [
                              Column(

                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text('Product name :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                        Text(
                                          products[index].pName.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SingleChildScrollView(scrollDirection: Axis.horizontal,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('produc price  :  ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                        Text(
                                          products[index].pPrice,
                                          style: TextStyle(
                                              fontSize: 25, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  SingleChildScrollView(scrollDirection: Axis.horizontal,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Quantity :  ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                        Text(
                                          products[index].pQuantity.toString(),
                                          style: TextStyle(
                                              fontSize: 25, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  SingleChildScrollView(scrollDirection: Axis.horizontal,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Total price  :  ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                        Text(
                                          {double.parse(products[index].pPrice)*products[index].pQuantity}.toString(),
                                          style: TextStyle(color: Colors.red,
                                              fontSize: 25, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                    Text('Side1  :${products[index].side1}  ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    Text('Side2  :${products[index].side2}  ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  ],),
                                  SizedBox(height: 20,),
                                  SingleChildScrollView(scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text('Day : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                        Text(
                                          products[index].orderTime.year.toString(),
                                          style: TextStyle(
                                              fontSize:20, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' - ${products[index].orderTime.month.toString()}',
                                          style: TextStyle(
                                              fontSize:20, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' - ${products[index].orderTime.day.toString()}',
                                          style: TextStyle(
                                              fontSize:20, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SingleChildScrollView(scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text('Time: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                        Text(
                                          products[index].orderTime.hour.toString(),
                                          style: TextStyle(
                                              fontSize:20, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' : ${products[index].orderTime.minute.toString()}',
                                          style: TextStyle(
                                              fontSize:20, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' : ${products[index].orderTime.second.toString()}',
                                          style: TextStyle(
                                              fontSize:20, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text('Load Orders'),
              );
            }
          }),
    );
  }
}
