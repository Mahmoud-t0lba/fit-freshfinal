import 'package:fit/Screens/150or250.dart';
import 'package:fit/Screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit/constants.dart';
import 'package:fit/providers/theme.dart';

class CategoryBar extends StatefulWidget {
  @override

  _CategoryBarState createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  List<String> text = [
    "Beef Meals",
    "Chicken Meals",
    "SeaFood Meals",
    "Sandwiches",
    "KetoGenic",
    "Salads",
    "Sides",
    "Desserts",
    "Drinks"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(height: MediaQuery.of(context).size.height*.2,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 150,
          width: double.infinity,
          child:  ListView(scrollDirection: Axis.horizontal,
            children: [
            category(text[0], 'assets/images/svg1.png'),
              category(text[1], 'assets/images/chicken svg.png'),
              category(text[2], 'assets/images/seafood.png'),
              category(text[3], 'assets/images/snad.png'),
              category(text[4], 'assets/images/keto.png'),
              category(text[5], 'assets/images/salades.png'),
              category(text[6], 'assets/images/sides.png'),
              category(text[7], 'assets/images/desserts.png'),
              category(text[8], 'assets/images/d.png'),



            ],

          ),

        ),
      ),
    );
  }
  category(String category,String data) {
    return GestureDetector(
      onTap: () {
        if(category =='Beef Meals' ||category=='Chicken Meals'||category=='SeaFood Meals')
        {
          Navigator.pushNamed(context, MeduimLarge.id, arguments: category);
        }
        else
          {
          Navigator.pushNamed(context, CartScreenCat.id, arguments: category);
          }
      },
      child: Stack(
        children: <Widget>[
          Container(

            height:  MediaQuery.of(context).size.height*.125,
            width:MediaQuery.of(context).size.width*.3,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color:Provider.of<ThemeCustom>(context).isdark == false
                      ? secondcardcolor
                      : Colors.white.withOpacity(.9),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child:
            Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(data,height: MediaQuery.of(context).size.height*.05,width:MediaQuery.of(context).size.width*.2 ,),
                ),SizedBox(height: 10,),Text (category,style: TextStyle(color: Provider.of<ThemeCustom>(context).isdark ==
                    false
                    ? secondtextcolor
                    : textmaincolor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),)],)
            ),
          ),

        ],
      ),
    );
}}
