import 'package:fit/Screens/signinscreen/signin.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/background.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/logo.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/signbutton.dart';
import 'package:flutter/material.dart';
import 'package:fit/fixedfield.dart';
import 'package:fit/services/auth.dart';

// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  static String id = ' forget';
  final auth = Auth();
  final GlobalKey<FormState> _forgetformkey = GlobalKey<FormState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundImage(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Logo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                  ),
                  Form(
                    key: _forgetformkey,
                    child: CustomTextField(
                      onclick: (value) {
                        _email = value;
                      },
                      hint: 'Enter Your Email',
                      secure: false,
                      prefix: Icons.email,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Email';
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .6,
                    height: MediaQuery.of(context).size.height * .08,
                    decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(25)),
                    child: Builder(
                      builder: (context) => SignButton(
                        function: () {
                          _forgetpass(context);
                        },
                        name: 'Reset Password',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // ignore: deprecated_member_use
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignInScreen.id);
                      },
                      child: Text(
                        'Return To SignIN',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _forgetpass(BuildContext context) {
    try {
      _forgetformkey.currentState.save();
      if (_forgetformkey.currentState.validate()) {
        auth.resetPassword(_email);
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(SnackBar(content: Text('Check Your Mail')));
      }
    } catch (e) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
