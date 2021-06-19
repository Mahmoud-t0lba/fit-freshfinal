import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/logo.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/signbutton.dart';
import 'package:fit/constants.dart';
import 'package:fit/fixedfield.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UPdatePassword extends StatefulWidget {
  static String id = 'pdate';
  @override
  _UPdatePasswordState createState() => _UPdatePasswordState();
}

class _UPdatePasswordState extends State<UPdatePassword> {
  GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String _email;
  String check;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeCustom>(context);
    check = _firebaseAuth.currentUser.email;

    return Scaffold(
      key: _key,
      backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
      body: ListView(
        children: [
          Logo(),
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
          ),
          Form(
            key: _keyform,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
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
                  name: 'Update Password',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _forgetpass(BuildContext context) {
    try {
      if (_keyform.currentState.validate() && check == _email) {
        _keyform.currentState.save();
        auth.resetPassword(_email);
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Check Your Mail'),
          backgroundColor: Colors.green,
        ));
      } else {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Correct Your Mail'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
