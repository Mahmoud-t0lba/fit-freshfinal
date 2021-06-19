import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/logo.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/signbutton.dart';
import 'package:fit/constants.dart';
import 'package:fit/fixedfield.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class UpdatePhone extends StatefulWidget {
  static const String id = 'update_phone';

  @override
  _UpdatePhoneState createState() => _UpdatePhoneState();
}

class _UpdatePhoneState extends State<UpdatePhone> {
  Auth _auth = Auth();
  TextEditingController _phone = TextEditingController();
  TextEditingController _code = TextEditingController();

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
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeCustom>(context);
    GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
          key: globalKey,
          backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Logo(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomTextField(
                  controller: _phone,
                  hint: "Phone",
                  prefix: Icons.phone_android,
                  type: TextInputType.phone,
                ),
              ),
              SignButton(
                function: () {
                  if (_phone.text.isEmpty) {
                    // ignore: deprecated_member_use
                    globalKey.currentState.showSnackBar(SnackBar(
                      content: Text('Please Enter Phone Numer'),
                      backgroundColor: Colors.red,
                    ));
                  } else if (_phone.text.length < 11 ||
                      _phone.text.length > 11 ||
                      _phone.text.length < 11 ||
                      _phone.text.length > 11 ||
                      _phone.text.characters.first != 0.toString() ||
                      _phone.text.characters.elementAt(1) != 1.toString()) {
                    // ignore: deprecated_member_use
                    globalKey.currentState.showSnackBar(SnackBar(
                      content: Text('Invalid Phone Numer'),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    _auth.updatePhone(userId, _phone.text);
                    Navigator.of(context).pop();
                  }
                },
                name: 'Update Phone',
              )
            ],
          )),
    );
  }

  // ignore: missing_return
  Future<bool> veritifyuser(String phone, context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
        phoneNumber: _phone.text,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential crend) async {
          UserCredential userCredential =
              await auth.signInWithCredential(crend);
          User user = userCredential.user;
          if (user != null) {
            _auth.updatePhone(userId, _phone.text);
            Navigator.of(context).pop();
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String vId, [int force]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('Give The Code'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _code,
                      )
                    ],
                  ),
                  actions: [
                    // ignore: deprecated_member_use
                    FlatButton(
                        onPressed: () async {
                          final code = _code.text.trim();
                          // ignore: unused_local_variable
                          AuthCredential authcredital = PhoneAuthProvider
                              // ignore: deprecated_member_use
                              .getCredential(
                                  verificationId: vId, smsCode: code);
                        },
                        child: Text('Confirm'))
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }
}
