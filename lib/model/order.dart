import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  int totlaprice;
  String address;
  String docid;
  int phonenum;
  String name;
  String orderBy;
  String comment;



  Order({
    this.address,
    this.totlaprice,
    this.docid,
    this.name,
    this.phonenum,
    this.orderBy,
    this.comment
  });

  factory Order.fromFirstore(DocumentSnapshot json){
    var _data = json.data();
    return Order(
      totlaprice : _data['totalprice'],
      address : _data['address'],
      docid :_data['docid'],
      phonenum : _data['phonenum'],
      name : _data['name'],
      orderBy: _data['orderBy'],
      comment: _data['comment'],
    );
  }

  toJson(){
    return {
      'totalprice' : totlaprice,
      'address' : address,
      'docid' : docid,
      'name' : name,
      'phonenum' : phonenum,
      'orderBy' : orderBy,
      'comment' : comment,
    };
  }
}
