import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit/fixedfield.dart';
import 'package:fit/model/product.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/services/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

import '../../constants.dart';

class AddOffers extends StatefulWidget {
  static String id = 'addproducoffe5re';

  @override
  _AddOffersState createState() => _AddOffersState();
}

class _AddOffersState extends State<AddOffers> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  final _store = Store();
  final maxLines = 5;
  String _name, _link, _discription, _category = 'Offers';
  String _price;
  String selected;
  File file;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              children: [
                Image.asset('assets/images/fit.png'),
                Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * .8,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                    child: file != null
                        ? Container(
                            child: Image.file(
                            file,
                            fit: BoxFit.cover,
                          ))
                        : GestureDetector(
                            onTap: () {
                              pickimage(context);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  color: Colors.green,
                                  size: 50,
                                ),
                                Text(
                                  "Upload Image",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                    key: _key,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: 'Enter Product Name',
                          secure: false,
                          onclick: (value) {
                            _name = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter name";
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hint: 'Enter Product Price',
                          secure: false,
                          onclick: (value) {
                            _price = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter price";
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: maxLines * 24.0,
                          child: TextFormField(
                            maxLines: maxLines,
                            decoration: InputDecoration(
                              hintText: 'Enter Discribtion',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "please enter discribtion";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              _discription = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 15,
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
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () async {
                      await uploadimage();
                      if (_key.currentState.validate() && _link != null) {
                        _key.currentState.save();
                        await _store.addProduct(Product(
                          pCategory: _category,
                          pDiscribtion: _discription,
                          pLink: _link,
                          pName: _name,
                          pPrice: _price,
                        ));
                        // ignore: deprecated_member_use
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('The Offer was Added'),
                          backgroundColor: Colors.green,
                        ));
                      }
                    },
                    child: Text(
                      'Add Offer',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Pacifico',
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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

  Future uploadimage() async {
    // ignore: unused_local_variable
    FirebaseStorage storage =
        // ignore: deprecated_member_use
        FirebaseStorage(storageBucket: 'gs://fitfresh-9859b.appspot.com');
    Reference reference =
        FirebaseStorage.instance.ref().child(p.basename(file.path));
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String url = await snapshot.ref.getDownloadURL();

    setState(() {
      _link = url;
    });
    print(_link);
  }
}
