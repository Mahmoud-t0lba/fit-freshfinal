import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier {

  String pid;
  String pName;
  String pPrice;
  String pCategory;
  String pLink;
  String pDiscribtion;
  int pQuantity;
  String protin;
  String cal;

  String fat;
  String carbs;
  String side1;
  String side2;
  String price2;
  String size ;
  String comment;


  /// adding favorite

  DateTime orderTime;

  Product({


    this.pid,
    this.pCategory,
    this.pDiscribtion,
    this.pLink,
    this.pName,
    this.pPrice,
    this.pQuantity,
    this.protin,
    this.cal,
    this.fat,
    this.carbs,
    this.side1,
    this.price2,
    this.side2,
    this.size,
    this.comment,

    this.orderTime,
  });

  ///method update favorite in database


  Product.fromJson(Map json) {

    pid = json['Pid'];
    pCategory = json['PCategory'];
    pDiscribtion = json['PDiscribtion'];
    pLink = json['PLink'];
    pName = json['PName'];
    pPrice = json['PPrice'];
    pQuantity = json['PQuantity'];
    protin = json['protin'];
    cal = json['cal'];
    fat = json['fat'];
    carbs = json['carbs'];
    side1 = json['side1'];
    side2 = json['side2'];
    price2 = json['price2'];
size =json['size'];
comment=json['com'];
    orderTime =json['PPorder'];
  }

  Map toJson() {
    Map <String ,dynamic>data = {};

    data['Pid'] = pid;
    data['PCategory'] = pCategory;
    data['PDiscribtion'] = pDiscribtion;
    data['PLink'] = pLink;
    data['PName'] = pName;
    data['PPrice'] = pPrice;
    data['PQuantity'] = pQuantity;
    data['protin'] = protin;
    data['cal'] = cal;
    data['fat'] = fat;
    data['carbs'] = carbs;
    data['side1'] = side1;
    data['side2'] = side2;
    data['price2'] = price2;
    data['size']=size;
    data['com']=comment;

    data['PPorder']=orderTime;
    return data;
  }
}
