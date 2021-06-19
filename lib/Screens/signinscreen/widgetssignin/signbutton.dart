import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final Function function;
  final String name;
  SignButton({this.function, this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .6,
      height: MediaQuery.of(context).size.height * .08,
      decoration: BoxDecoration(
          color: Colors.lightGreen, borderRadius: BorderRadius.circular(25)),
      child: Builder(
        builder: (context) =>
            // ignore: deprecated_member_use
            FlatButton(
          onPressed: function,
          child: Text(
            name,
            style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}
