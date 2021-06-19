import 'package:fit/constants.dart';

import 'package:fit/model/product.dart';
import 'package:flutter/material.dart';
import 'package:fit/services/store.dart';
import 'package:fit/fixedfield.dart';

// ignore: must_be_immutable
class EditDetails extends StatelessWidget {
  static String id = 'Edit';
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _store = Store();
  String _name, _link, _discription, _category;
  String _price;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              children: [
                Image.asset('assets/images/fit.png'),
                Form(
                    key: _key,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: 'Enter Product Name',
                          secure: false,
                          onclick: (value) {
                            _name = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter name";
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hint: 'Enter Product Price',
                          secure: false,
                          onclick: (value) {
                            _price = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter price";
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hint: 'Enter Product Category',
                          secure: false,
                          onclick: (value) {
                            _category = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter categroy";
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hint: 'Enter Product Discribtion',
                          secure: false,
                          onclick: (value) {
                            _discription = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter discribtoin";
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hint: 'Enter Product ImageLink',
                          secure: false,
                          onclick: (value) {
                            _link = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter imagelink";
                            }
                          },
                        ),
                      ],
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .08,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(25)),
                  child:
                      // ignore: deprecated_member_use
                      FlatButton(
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        _store.editproduct(
                            product.pid,
                            ({
                              kProductprice: _price,
                              kproductCategory: _category,
                              kproductDiscribtion: _discription,
                              kImagelink: _link,
                              kProductname: _name
                            }));
                      }
                    },
                    child: Text(
                      'Edit Product',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Pacifico',
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
