import 'package:fit/Screens/adminscreens/addofferspages.dart';
import 'package:fit/Screens/adminscreens/addproduct.dart';
import 'package:fit/Screens/adminscreens/editproduct.dart';
import 'package:fit/Screens/adminscreens/topscreen.dart';
import 'package:fit/Screens/adminscreens/vieworders.dart';
import 'package:flutter/material.dart';

class AdminPageHome extends StatelessWidget {
  static String id = 'Adminpage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: deprecated_member_use
            RaisedButton(
              color: Colors.lightGreen,
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              child: Text(
                'Add Product',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              color: Colors.lightGreen,
              onPressed: () {
                Navigator.pushNamed(context, AddOffers.id);
              },
              child: Text(
                'add Offer',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              color: Colors.lightGreen,
              onPressed: () {
                Navigator.pushNamed(context, EditProductPage.id);
              },
              child: Text(
                'Edit Product',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              color: Colors.lightGreen,
              onPressed: () {
                Navigator.pushNamed(context, TopHomeScreen.id);
              },
              child: Text(
                'Add Photos To Home',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              color: Colors.lightGreen,
              onPressed: () {
                Navigator.pushNamed(context, VeiwOrdersPage.id);
              },
              child: Text(
                'View Orders',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
