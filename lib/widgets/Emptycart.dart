import 'package:fit/Screens/category_screen.dart';
import 'package:fit/providers/theme.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    Key key,
    @required this.theme,
  }) : super(key: key);

  final ThemeCustom theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            color: Colors.green,
            size: 130,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'You Cart is Empty',
            style: TextStyle(
              color: theme.isdark == true ? Colors.black : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Add items you want to shop',
            style: TextStyle(
              color: theme.isdark == true ? Colors.black : Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed(Category.id);
            },
            color: Colors.red,
            child: Text(
              'SHOP NOW',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
