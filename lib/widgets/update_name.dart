import 'package:fit/Screens/signinscreen/widgetssignin/logo.dart';
import 'package:fit/Screens/signinscreen/widgetssignin/signbutton.dart';
import 'package:fit/constants.dart';
import 'package:fit/fixedfield.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class UpdateName extends StatefulWidget {
  static const String id = 'update_name';

  @override
  _UpdateNameState createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  Auth _auth = Auth();
  TextEditingController _name = TextEditingController();
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
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeCustom>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Logo(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomTextField(
                  controller: _name,
                  hint: "Name",
                  prefix: Icons.person,
                ),
              ),
              SignButton(
                function: () {
                  _auth.updateUserName(userId, _name.text);
                  Navigator.of(context).pop();
                },
                name: 'Update Name',
              )
            ],
          )),
    );
  }
}
