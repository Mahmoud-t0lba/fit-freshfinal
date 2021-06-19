import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/Screens/homepagescreen/homepagescreen.dart';
import 'package:fit/Screens/navigaterHandA.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/background.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/forgetpass.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/gosignup.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/logo.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/signbutton.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/visitus.dart';
import 'package:fit/providers/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fit/fixedfield.dart';
import 'package:fit/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static String id = 'SignIn';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _signinformkey = GlobalKey<FormState>();
  String _email, _password;
  final auth = Auth();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModalHud>(context).isloading,
      child: Scaffold(
        body: BackGroundImage(
          child: ListView(
            children: [
              Column(
                children: [
                  Logo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Form(
                    key: _signinformkey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: 'Enter  Email',
                            prefix: Icons.email,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return "please enter email";
                              }
                              return null;
                            },
                            onclick: (value) {
                              _email = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hint: 'Enter  Password',
                            secure: true,
                            prefix: Icons.lock,
                            validator: (value) {
                              if (value.isEmpty || value.length < 6) {
                                return "please enter password or write greater than 6 character";
                              }
                            },
                            onclick: (value) {
                              _password = value;
                            },
                          ),
                          ForgetPassRow(),
                          Builder(
                              builder: (context) => SignButton(
                                    function: () async {
                                      _signin(context);
                                    },
                                    name: 'Sign In',
                                  )),
                          GosignUP(),
                          SizedBox(
                            height: 10,
                          ),
                          VisitUs(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signin(BuildContext context) async {
    // ignore: unused_local_variable
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// ignore: unused_local_variable
    User user;
    final modalhus = Provider.of<ModalHud>(context, listen: false);
    modalhus.changeisloading(true);
    try {
      if (_signinformkey.currentState.validate()) {
        _signinformkey.currentState.save();
        modalhus.changeisloading(true);
        if (_email == 'abdelwahabhassan2000@gmail.com') {
          await auth.signIn(_email, _password);
          Navigator.popAndPushNamed(context, NavigaterPage.id);
          modalhus.changeisloading(false);
        } else {
          await auth.signIn(_email, _password);
          Navigator.popAndPushNamed(context, HomePageScreen.id);
          modalhus.changeisloading(false);
        }
      } else {
        modalhus.changeisloading(false);
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(SnackBar(content: Text('Complete required data')));
      }
    } catch (e) {
      modalhus.changeisloading(false);
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
