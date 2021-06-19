import 'package:fit/Screens/cart_screen.dart';
import 'package:fit/constants.dart';
import 'package:fit/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Cartscreen150.dart';

class MeduimLarge extends StatefulWidget {
  static String id ='aa0';
  @override
  _MeduimLargeState createState() => _MeduimLargeState();
}

class _MeduimLargeState extends State<MeduimLarge> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeCustom>(context);
   String category = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(onTap: ()
              {
                Navigator.pushNamed(context, Cart150.id,arguments: category);
              },
                child: Container(
           height: MediaQuery.of(context).size.height*.25,
                  width: MediaQuery.of(context).size.width*.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child:Center(child: Text('150 GM',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),))
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: ()
                {
                  Navigator.pushNamed(context, CartScreenCat.id,arguments: category);
                },
                child: Container(
                    height: MediaQuery.of(context).size.height*.25,
                    width: MediaQuery.of(context).size.width*.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child:Center(child: Text('250 GM',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),))
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
