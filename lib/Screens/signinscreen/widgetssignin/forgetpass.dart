import 'package:fit/Screens/forgetpasswordscreen/forgetpsswordscreen.dart';
import 'package:flutter/material.dart';

class ForgetPassRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, ForgetPasswordScreen.id);
          },
          child: Text(
            'Forget your Password ?',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
