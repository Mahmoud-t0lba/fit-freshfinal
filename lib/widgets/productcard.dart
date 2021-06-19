import 'package:flutter/material.dart';
import 'package:fit/constants.dart';
import 'package:provider/provider.dart';
import 'package:fit/providers/theme.dart';

class ProductCard extends StatelessWidget {
  final String url;
  final String name;
  final String cal;
  final String price;
  final Widget fav;
  ProductCard({this.url, this.name, this.price, @required this.fav, this.cal});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 15),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Provider.of<ThemeCustom>(context).isdark == false
                  ? Colors.white.withOpacity(0.4)
                  : secondcardcolor,
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
          color: Provider.of<ThemeCustom>(context).isdark == false
              ? secondcardcolor
              : Colors.white.withOpacity(.9),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          // ignore: deprecated_member_use
          overflow: Overflow.visible,
          children: [
            Positioned(
                top: 10,
                right: 13,
                child: Container(
                  height: MediaQuery.of(context).size.height * .25,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width * .45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Positioned(
              bottom: 12.8,
              left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Provider.of<ThemeCustom>(context).isdark == false
                            ? secondtextcolor
                            : textmaincolor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(price,
                          style: TextStyle(
                              color: Provider.of<ThemeCustom>(context).isdark ==
                                      false
                                  ? secondtextcolor
                                  : textmaincolor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 3.5,
                      ),
                      Text(
                        'L.E',
                        style: TextStyle(
                            color: Provider.of<ThemeCustom>(context).isdark ==
                                    false
                                ? secondtextcolor
                                : textmaincolor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
