import 'package:fit/Screens/signinscreen/widgetssignin/logo.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/signbutton.dart';
import 'package:fit/fixedfield.dart';
import 'package:fit/model/images.dart';
import 'package:flutter/material.dart';
import 'package:fit/services/store.dart';

// ignore: must_be_immutable
class TopHomeScreen extends StatelessWidget {
  static String id = 'topjome';

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _store = Store();

  String _img1, _img2, _img3, _img4, _img5, _img6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Logo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: 'Enter Link of Image1 ',
                            prefix: Icons.add_a_photo,
                            onclick: (value) {
                              _img1 = value;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          CustomTextField(
                            hint: 'Enter Link of Image2 ',
                            prefix: Icons.add_a_photo,
                            onclick: (value) {
                              _img2 = value;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          CustomTextField(
                            hint: 'Enter Link of Image3 ',
                            prefix: Icons.add_a_photo,
                            onclick: (value) {
                              _img3 = value;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          CustomTextField(
                            hint: 'Enter Link of Image4 ',
                            prefix: Icons.add_a_photo,
                            onclick: (value) {
                              _img4 = value;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          CustomTextField(
                            hint: 'Enter Link of Image5 ',
                            prefix: Icons.add_a_photo,
                            onclick: (value) {
                              _img5 = value;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          CustomTextField(
                            hint: 'Enter Link of Image6 ',
                            prefix: Icons.add_a_photo,
                            onclick: (value) {
                              _img6 = value;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          SignButton(
                            name: "Add Photos",
                            function: () {
                              _formkey.currentState.save();
                              _store.addTopHome(Imageeees(
                                image1: _img1,
                                image2: _img2,
                                image3: _img3,
                                image4: _img4,
                                image5: _img5,
                                image6: _img6,
                              ));
                            },
                          )
                        ],
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
