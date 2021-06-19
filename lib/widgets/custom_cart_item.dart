import 'package:fit/providers/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/constants.dart';
import 'package:fit/model/product.dart';

class CustomCartItem extends StatefulWidget {
  final String image;

  final String name;
  final String calories;
  final String price;
  final Function onPressed;
  // ignore: non_constant_identifier_names
  final Widget FAvourite;
  final Product product;

  CustomCartItem({
    this.image,
    this.product,
    this.name,
    this.calories,
    this.price,
    // ignore: non_constant_identifier_names
    this.FAvourite,
    this.onPressed,
  });

  @override
  _CustomCartItemState createState() => _CustomCartItemState();
}

class _CustomCartItemState extends State<CustomCartItem> {
  bool isFind;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Stack(
          // overflow: Overflow.visible,
          children: [
            Container(
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
            ),
            Positioned(
                top: 15,
                right: 11,
                child: Container(
                  height: MediaQuery.of(context).size.height * .18,
                  width: MediaQuery.of(context).size.width * .37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Positioned(
              bottom: 12.8,
              left: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            color: Provider.of<ThemeCustom>(context).isdark ==
                                    false
                                ? secondtextcolor
                                : textmaincolor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      widget.calories + ' Calories',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(widget.price,
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
            Consumer<Favorite>(
              builder: (context, data, child) {
                for (var data in data.favorite) {
                  if (data.pid == widget.product.pid) {
                    return Positioned(
                      bottom: 8,
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          print('this is product ${widget.product}');
                          Provider.of<Favorite>(context, listen: false)
                              .deletingFavorite(widget.product.pid);
                        },
                        child: Container(
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  }
                }
                return Positioned(
                  bottom: 8,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      Provider.of<Favorite>(context, listen: false)
                          .addingFavorite(widget.product);
                    },
                    child: Container(
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
