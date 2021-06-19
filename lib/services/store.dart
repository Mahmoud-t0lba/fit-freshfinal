import 'package:fit/model/images.dart';
import 'package:fit/model/product.dart';
import 'package:fit/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shared_preferences/shared_preferences.dart';



class Store {
  String userId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void getCurrentUser()async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('userId');
  }

  Store(){
    getCurrentUser();
  }


  /// adding product in products list
  addProduct(Product product) async {
    await _firestore.collection(kProductcollectiion).add({
      kImagelink: product.pLink,
      kproductCategory: product.pCategory,
      kproductDiscribtion: product.pDiscribtion,
      kProductname: product.pName,
      kProductprice: product.pPrice,
      kcal: product.cal,
      kfat: product.fat,
      kprotin: product.protin,
      kcarb: product.carbs,
      'price2': product.price2,

      'PPorder':product.orderTime,
    'PQuantity' :product.pQuantity,
      'size':product.size,
      'com':product.comment


    });
  }

  addTopHome(Imageeees imageeees) async {
    await _firestore.collection('Top of Screen').add({
      kimage1: imageeees.image1,
      kimage2: imageeees.image2,
      kimage3: imageeees.image3,
      kimage4: imageeees.image4,
      kimage5: imageeees.image5,
      kimage6: imageeees.image6,
    });
  }

  Stream<QuerySnapshot> loadHomeScreen() {
    return _firestore.collection('Top of Screen').snapshots();
  }

  /// fetching all productions
  Stream<QuerySnapshot> editProducts() {
    return _firestore.collection(kProductcollectiion).snapshots();
  }

  /// deleting product by id
  deleteproduct(documentId) {
    _firestore.collection(kProductcollectiion).doc(documentId).delete();
  }

  /// editing product by id
  editproduct(id, data) {
    _firestore.collection(kProductcollectiion).doc(id).update(data);
  }

  /// new method store orders
  storeorders(data, List<Product> products, userId) async {
    var documentRef =
        FirebaseFirestore.instance.collection('orders').doc(userId);
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection('orderDetails').doc().set({
        kProductname: product.pName,
        kProductprice: product.pPrice,
        Kquantity: product.pQuantity,
        kImagelink: product.pLink,
        'orderBy' : userId,
        kOrderTime: DateTime.now(),
      });
    }
  }

  /// fetching all orders
  Stream<QuerySnapshot> loadorders() {
    return _firestore.collection(Korders).snapshots();
  }


  /// fetching order by id . recommend not using this you can use this with ui.
  Stream<QuerySnapshot> loadordersdetails(dicid) {
    return _firestore
        .collection(Korders)
        .doc(dicid)
        .collection(Kordersdetails)
        .snapshots();
  }
}
