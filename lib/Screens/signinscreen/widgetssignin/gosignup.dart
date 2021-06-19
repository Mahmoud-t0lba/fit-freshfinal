import 'package:fit/Screens/signupscreen/signupscreen.dart';
import 'package:flutter/material.dart';

class GosignUP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account ?',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, SignUpScreen.id);
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
