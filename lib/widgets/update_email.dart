import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/logo.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/signbutton.dart';
import 'package:fit/constants.dart';
import 'package:fit/fixedfield.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateEmail extends StatefulWidget {
  static const String id = 'update_email';

  @override
  _UpdateEmailState createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  Auth _auth = Auth();
  TextEditingController _email = TextEditingController();
  String userId;

  void getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString('userId');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeCustom>(context);
    GlobalKey<ScaffoldState> sk = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
          key: sk,
          backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Logo(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomTextField(
                  controller: _email,
                  hint: "Email",
                  prefix: Icons.email,
                ),
              ),
              SignButton(
                function: () async {
                  try {
                    if (_email.text.isNotEmpty &&
                        auth.currentUser.email != _email.text &&
                        _email.text.contains('@', 0) &&
                        _email.text.endsWith('.com')) {
                      await _auth.updateEmail(userId, _email.text);

                      // ignore: deprecated_member_use
                      sk.currentState.showSnackBar(SnackBar(
                        content: Text(
                            'This operation is sensitive and requires recent authentication. Log in again before retrying this request.'),
                        backgroundColor: Colors.red,
                      ));
                    } else if (_email.text.isEmpty) {
                      // ignore: deprecated_member_use
                      sk.currentState.showSnackBar(SnackBar(
                        content: Text('Enter Your Mail Please.'),
                        backgroundColor: Colors.red,
                      ));
                    } else if (_email.text == auth.currentUser.email) {
                      // ignore: deprecated_member_use
                      sk.currentState.showSnackBar(SnackBar(
                        content: Text('Your Email Is Updated Successfully.'),
                        backgroundColor: Colors.green,
                      ));
                    } else {
                      // ignore: deprecated_member_use
                      sk.currentState.showSnackBar(SnackBar(
                        content: Text('Invalid Mail Address.'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  } catch (e) {
                    // ignore: deprecated_member_use
                    sk.currentState.showSnackBar(SnackBar(
                      content: Text(e),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                name: 'update Email',
              )
            ],
          )),
    );
  }
}
