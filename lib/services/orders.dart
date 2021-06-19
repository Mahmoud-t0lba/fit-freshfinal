
import 'package:cloud_firestore/cloud_firestore.dart';



class Orders {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// fetching all order to admin
  Stream<QuerySnapshot> fetchingAllOrder() {
    return _firestore.collection('orders').snapshots();
  }

  /// fetching order details
  Stream<QuerySnapshot> fetchingOrderDetails(documentId) {
    return _firestore.collection('orders').doc(documentId).collection('orderDetails').snapshots();
  }

  /// fetching my order
 // Stream<List<Order>> fetchingMyOrder(userIDD){
 //  var _ref = _firestore.collection('orders').doc(userIDD).collection('orderDetails');
 //  return _ref.snapshots().map((event) {
 //    return event.docs.map((e) {
 //      return Order.fromFirstore(e);
 //    }).toList();
 //  });
 // }
 

/// fetching my order
Stream<QuerySnapshot> fetchingMyOrder(userId) {
    print('this is user id $userId');
 final _collection =  FirebaseFirestore.instance.collection("orders").where("orderBy", isEqualTo: userId).snapshots();
 return _collection;
}


}
