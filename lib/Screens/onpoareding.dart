import 'package:fit/Screens/signinscreen/signin.dart';
import 'package:fit/responsive/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class OnPoardingScreen extends StatefulWidget {
  static String id = 'onpoarding';
  @override
  _OnPoardingScreenState createState() => _OnPoardingScreenState();
}

class _OnPoardingScreenState extends State<OnPoardingScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'assets/images/F1.jpg',
      'assets/images/F2.jpg',
      'assets/images/F3.jpg'
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Swiper(
            duration: 1,
            pagination: new SwiperPagination(),
            onIndexChanged: (int i) {
              i = 0;
              i++;
            },
            itemCount: images.length,
            itemBuilder: (BuildContext context, int i) {
              return Image.asset(
                images[i],
                fit: BoxFit.fill,
              );
            },
            autoplay: true,
          ),
          Positioned(
            bottom: 12,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.6),
                  borderRadius: BorderRadius.circular(30)),
              // ignore: deprecated_member_use
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.id);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Skip',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: fromRealHeight(5, context),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
