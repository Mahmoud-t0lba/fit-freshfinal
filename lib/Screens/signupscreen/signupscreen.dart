import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/Screens/homepagescreen/homepagescreen.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/background.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/logo.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/signbutton.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/visitus.dart';
import 'package:fit/Screens/signupscreen/signwidgets/gosignin.dart';
import 'package:fit/providers/Model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit/fixedfield.dart';
import 'package:fit/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signupformkey = GlobalKey<FormState>();
  String _email, _password, _name, _phonenum;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Form(
                    key: _signupformkey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: 'Enter  Name',
                            prefix: Icons.person,
                            validator: (value) {
                              if (value.isEmpty || value.length < 3) {
                                return "please enter username ";
                              }
                              return null;
                            },
                            onclick: (value) {
                              _name = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hint: 'Enter phone',
                            prefix: Icons.phone,
                            validator: (value) {
                              if (value.length < 11 || value.length > 11) {
                                return 'Invalid phone Number';
                              } else if (value.isEmpty ||
                                  value.length < 11 ||
                                  value.length > 11 ||
                                  value.characters.first != 0.toString() ||
                                  value.characters.elementAt(1) !=
                                      1.toString()) {
                                return "Please Enter Phone";
                              }
                            },
                            onclick: (value) {
                              _phonenum = value;
                            },
                            type: TextInputType.phone,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hint: 'Enter  Email',
                            prefix: Icons.email,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return "please Enter Email";
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
                              if (value.isEmpty || value.length < 8) {
                                return "please enter password or write greater than 8 character";
                              }
                            },
                            onclick: (value) {
                              _password = value;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .07,
                          ),
                          Builder(
                              builder: (context) => SignButton(
                                    function: () async {
                                      _signup(context);
                                    },
                                    name: 'Sign Up',
                                  )),
                          GoSignin(),
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

  void _signup(BuildContext context) async {
    // ignore: unused_local_variable
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final modalhud = Provider.of<ModalHud>(context, listen: false);
    modalhud.changeisloading(true);
    try {
      if (_signupformkey.currentState.validate()) {
        modalhud.changeisloading(true);
        _signupformkey.currentState.save();
        await auth.signUp(_email, _password, _name, _phonenum);

        modalhud.changeisloading(false);
        Navigator.pushNamed(context, HomePageScreen.id);
      } else {
        modalhud.changeisloading(false);

        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(SnackBar(content: Text('Complete required data')));
      }
    } catch (e) {
      modalhud.changeisloading(false);
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
