import 'dart:io';
import 'package:fit/Screens/updatepassword.dart';
import 'package:fit/Screens/updatephone.dart';
import 'package:fit/widgets/update_email.dart';
import 'package:fit/widgets/update_name.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/Screens/signinscreen/signin.dart';
import 'package:fit/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataScreen extends StatefulWidget {
  static String id = 'userdata';

  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  File file;
  String imagepath;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();

    loadimage();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    String phone = user.phoneNumber;

    // String emailupdate;
    final _auth = Auth();

    final theme = Provider.of<ThemeCustom>(context);
    return Scaffold(
      backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
      body: FutureBuilder(
        future: _auth.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.isAdmin);
            print(snapshot.data.name);
            print(snapshot.data.email);
            print(snapshot.data.phone);
            // String password;
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset('assets/images/fit.png'),
                        ),
                        Badge(
                          child: imagepath != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(File(imagepath)),
                                  radius: 75,
                                )
                              : CircleAvatar(
                                  backgroundImage: file != null
                                      ? FileImage(
                                          file,
                                        )
                                      : AssetImage('assets/images/fit.png'),
                                  radius: 75,
                                ),
                          badgeContent: GestureDetector(
                              onTap: () => pickimage(context),
                              child: Icon(Icons.add_a_photo)),
                          showBadge: true,
                          badgeColor: Colors.lightGreen,
                          position: BadgePosition(bottom: 4, end: 4),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Badge(
                          badgeColor: Colors.lightGreen,
                          position: BadgePosition(bottom: -7, end: 4),
                          badgeContent: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, UpdateName.id)
                                  .then((value) => setState(() => {}));
                            },
                            child: Icon(Icons.edit),
                          ),
                          child: Dataitem(
                            data: snapshot.data.name,
                            icon: Icons.person,
                          ),
                        ),

                        SizedBox(
                          height: 25,
                        ),
                        Badge(
                          badgeColor: Colors.lightGreen,
                          position: BadgePosition(bottom: -7, end: 4),
                          badgeContent: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, UpdateEmail.id)
                                  .then((value) => setState(() => {}));
                            },
                            child: Icon(Icons.edit),
                          ),
                          child: Dataitem(
                            data: snapshot.data.email,
                            icon: Icons.email,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Badge(
                          badgeColor: Colors.lightGreen,
                          position: BadgePosition(bottom: -7, end: 4),
                          badgeContent: GestureDetector(
                            onTap: () {
                              String phonuu = user.phoneNumber;
                              setState(() {
                                phonuu = phone;
                                print(phonuu);
                              });
                              Navigator.pushNamed(
                                context,
                                UpdatePhone.id,
                              ).then((value) => setState(() => {}));
                            },
                            child: Icon(Icons.edit),
                          ),
                          child: Dataitem(
                            data: snapshot.data.phone,
                            icon: Icons.phone,
                          ),
                        ),
                        SizedBox(height: 25),
                        Badge(
                          badgeColor: Colors.lightGreen,
                          position: BadgePosition(bottom: -7, end: 4),
                          badgeContent: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                UPdatePassword.id,
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                          child: Dataitem(
                            icon: Icons.lock_outline,
                            data: '***********',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                saveimage(file.path);

                                Alert(
                                  title: 'Profile Updated',
                                  context: context,
                                  type: AlertType.success,
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      width: 120,
                                    )
                                  ],
                                ).show();
                                Navigator.popAndPushNamed(
                                    context, UserDataScreen.id);
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'Save Photo',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * .09,
                                width: MediaQuery.of(context).size.width * .9,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                auth.currentUser.delete();
                                await _auth.signOut();
                                Navigator.pushNamed(context, SignInScreen.id);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .09,
                                width: MediaQuery.of(context).size.width * .9,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: Text(
                                    'Delete My Account',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        // ,SizedBox(height: 25,),
                        // Dataitem(data: email,icon: Icons.lock,)
                        // ,SizedBox(height: 25,),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Loadig.....',
                style: TextStyle(
                  fontSize: 25,
                  color: theme.isdark == true ? kmaincolor : ksecondcolor,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  pickimage(mcontext) {
    return showDialog(
        context: mcontext,
        builder: (con) {
          return SimpleDialog(
            backgroundColor: Provider.of<ThemeCustom>(context).isdark == true
                ? ksecondcolor
                : kmaincolor,
            title: Text(
              'UpdatePhoto',
              style: TextStyle(
                  color: Provider.of<ThemeCustom>(context).isdark == true
                      ? kmaincolor
                      : ksecondcolor,
                  fontSize: 20),
            ),
            children: [
              SimpleDialogOption(
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: pickfromgallery,
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo,
                        color: Colors.lightGreen,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Pick From Gallery',
                        style: TextStyle(
                            color:
                                Provider.of<ThemeCustom>(context).isdark == true
                                    ? kmaincolor
                                    : ksecondcolor,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SimpleDialogOption(
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: pickfromcamera,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        color: Colors.lightGreen,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Pick From Comera',
                        style: TextStyle(
                            color:
                                Provider.of<ThemeCustom>(context).isdark == true
                                    ? kmaincolor
                                    : ksecondcolor,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SimpleDialogOption(
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Cancel',
                        style: TextStyle(
                            color:
                                Provider.of<ThemeCustom>(context).isdark == true
                                    ? kmaincolor
                                    : ksecondcolor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }

  void pickfromcamera() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      file = imageFile;
    });
  }

  void pickfromgallery() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 360, maxWidth: 360);
    setState(() {
      file = imageFile;
    });
  }

  void saveimage(path) async {
    SharedPreferences imagesave = await SharedPreferences.getInstance();
    imagesave.setString('image', path);
  }

  void loadimage() async {
    SharedPreferences imagesave = await SharedPreferences.getInstance();
    setState(() {
      imagepath = imagesave.getString(
        'image',
      );
    });
  }
}

class Dataitem extends StatelessWidget {
  final String data;
  final IconData icon;

  Dataitem({this.data, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Provider.of<ThemeCustom>(context).isdark == false
            ? secondcardcolor
            : Colors.white.withOpacity(0.4),
      ),
      child: Center(
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: Colors.lightGreen,
            ),
            SizedBox(
              width: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                data,
                style: TextStyle(
                    fontSize: 12.5,
                    color: Provider.of<ThemeCustom>(context).isdark == false
                        ? secondtextcolor
                        : textmaincolor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
