import 'package:fit/Screens/signinscreen/signin.dart';
import 'package:flutter/material.dart';

class GoSignin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account ?',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        // ignore: deprecated_member_use
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, SignInScreen.id);
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
