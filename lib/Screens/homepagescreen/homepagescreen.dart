import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/Screens/aboutus.dart';
import 'package:fit/Screens/offers.dart';
import 'package:fit/Screens/signinscreen/signin.dart';
import 'package:fit/Screens/userdatascree.dart';
import 'package:fit/constants.dart';
import 'package:fit/model/user_modal.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/responsive/screen.dart';
import 'package:fit/services/auth.dart';
import 'package:fit/Screens/homepagescreen/Widgetshome/appbar.dart';
import 'package:fit/widgets/bottomnavigationbar.dart';
import 'package:fit/widgets/categorybar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fit/widgets/category.dart';
import 'package:fit/widgets/topscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  static String id = 'Homescreen';

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  Auth auth = Auth();

  localdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString('Favourite');
  }

  String notify;
  void initState() {
    super.initState();
    //configOneSignal();
    localdata();
  }

  List<String> categories = [
    'Beef Meals',
    "Chicken Meals",
    'SeaFood Meals',
    'Sandwicehs',
    'KetoGenic',
    'Salades',
    'Sides',
    'Deserts',
    'Drinks'
  ];

  int index = 0;

  double rate;

  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    final theme = Provider.of<ThemeCustom>(context);
    final admin = Provider.of<UserModal>(context);
    print(admin.isAdmin);
    return Scaffold(
      backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
      bottomNavigationBar: CurvedBottom(),
      drawer: Drawer(
        child: Container(
          color: theme.isdark == true ? Colors.green[900] : kmaincolor,
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.isdark == true ? Colors.green[900] : kmaincolor,
                ),
                height: MediaQuery.of(context).size.height * .3,
                child: Image.asset('assets/images/fit.png'),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .7,
                decoration: BoxDecoration(
                    color: theme.isdark == true ? kmaincolor : ksecondcolor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60),
                        topLeft: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 35),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          draweritem('Home', Icons.home, () {
                            Navigator.pop(context);
                          }),
                          SizedBox(height: fromRealHeight(3, context)),
                          draweritem('My Orders', Icons.assistant, () {
                            Navigator.pushNamed(context, Offers.id);
                          }),
                          SizedBox(height: fromRealHeight(3, context)),
                          draweritem('About us', Icons.add_call, () {
                            Navigator.pushNamed(context, AboutUs.id);
                          }),
                          SizedBox(height: fromRealHeight(3, context)),
                          draweritem('Settings', Icons.settings, () {
                            Navigator.pushNamed(context, UserDataScreen.id);
                          }),
                          SizedBox(
                            height: fromRealHeight(3, context),
                          ),
                          draweritem('Log Out', Icons.lock, () async {
                            try {
                              await auth.signOut();
                              Navigator.popAndPushNamed(
                                  context, SignInScreen.id);
                            } catch (e) {
                              print(e);
                            }
                          }),
                          SizedBox(height: fromRealHeight(3, context)),
                          Row(
                            children: [
                              // ignore: deprecated_member_use
                              FlatButton(
                                  onPressed: () {
                                    theme.changeisloading(false);
                                  },
                                  child: (Icon(
                                    Icons.nightlight_round,
                                    color: Provider.of<ThemeCustom>(context)
                                                .isdark ==
                                            false
                                        ? secondtextcolor
                                        : textmaincolor,
                                  ))),
                              // ignore: deprecated_member_use
                              FlatButton(
                                onPressed: () {
                                  theme.changeisloading(true);
                                },
                                child: (Icon(
                                  Icons.wb_sunny,
                                  color: Provider.of<ThemeCustom>(context)
                                              .isdark ==
                                          false
                                      ? secondtextcolor
                                      : textmaincolor,
                                )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CAppBar(),
              HighLight(),
              CategoryBar(),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              categoryByName('Offers')
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector draweritem(String n, IconData i, Function f) {
    return GestureDetector(
      onTap: f,
      child: Row(
        children: [
          Icon(
            i,
            size: 30,
            color: Provider.of<ThemeCustom>(context).isdark == false
                ? secondtextcolor
                : textmaincolor,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            n,
            style: TextStyle(
              fontSize: 20,
              color: Provider.of<ThemeCustom>(context).isdark == false
                  ? secondtextcolor
                  : textmaincolor,
            ),
          )
        ],
      ),
    );
  }

/*  void configOneSignal() async {
    await OneSignal.shared.init('e2d360a5-514a-4a29-beec-f07897e26bf9');
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared.setNotificationReceivedHandler((openedResult) {
      setState(() {
        notify = openedResult.jsonRepresentation().replaceAll('\\n', '\n');
      });
    });
  } */
}
