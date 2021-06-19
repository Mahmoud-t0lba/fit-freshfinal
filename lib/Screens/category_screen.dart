import 'package:fit/Screens/150or250.dart';
import 'package:fit/Screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/constants.dart';

class Category extends StatelessWidget {
  static const String id = "category_screen";
 final List<String> images = [
    "https://scontent-mrs2-1.xx.fbcdn.net/v/t1.0-9/131825467_1502382693294441_1918749046520327138_o.jpg?_nc_cat=111&ccb=2&_nc_sid=730e14&_nc_ohc=UP8A37zN-LMAX_zKsCG&_nc_ht=scontent-mrs2-1.xx&oh=1ac3052749c25b65e91c6b2971092ee9&oe=60071476",
    "https://scontent-mrs2-2.xx.fbcdn.net/v/t1.0-9/128041985_3455180301237227_6877680777001948518_o.jpg?_nc_cat=108&ccb=2&_nc_sid=8bfeb9&_nc_ohc=gpXnh1RnMy0AX9Vk4-5&_nc_ht=scontent-mrs2-2.xx&oh=4e8b707041473782e8c659311609073c&oe=6006257C",
    "https://scontent.fcai1-2.fna.fbcdn.net/v/t1.0-9/38693350_1811930882228852_7264020751127150592_o.jpg?_nc_cat=103&ccb=2&_nc_sid=730e14&_nc_ohc=N4ZhXFK0bs0AX-ZGKyB&_nc_ht=scontent.fcai1-2.fna&oh=e2d0d18a133c7213daf35f68bbd3c3ac&oe=6006DC86",
    "https://scontent.fcai1-2.fna.fbcdn.net/v/t1.0-9/130746825_3486567731431817_1368477323019316222_o.jpg?_nc_cat=102&ccb=2&_nc_sid=8bfeb9&_nc_ohc=hyoVUuWTkTsAX94zeoA&_nc_ht=scontent.fcai1-2.fna&oh=bf1cb43fbb4fbf0af3d79df997e67c41&oe=6008C970",
    "https://scontent.fcai1-2.fna.fbcdn.net/v/t1.0-9/79859316_2598328700255729_7360771469359448064_n.jpg?_nc_cat=101&ccb=2&_nc_sid=8bfeb9&_nc_ohc=wuh9R_rtOCAAX_tXlY5&_nc_ht=scontent.fcai1-2.fna&oh=aaed3f687d7b456f3a48f8372fec22bc&oe=6006DE6B",
    "https://scontent-mrs2-2.xx.fbcdn.net/v/t1.0-9/29432663_1643522109069731_8721229109423767552_o.jpg?_nc_cat=110&ccb=2&_nc_sid=730e14&_nc_ohc=577bTk_e2vEAX8AjxMl&_nc_ht=scontent-mrs2-2.xx&oh=01ace30c11db00be297aff71bc184f8a&oe=6006FE99",
    "https://scontent-mrs2-1.xx.fbcdn.net/v/t1.0-9/41026227_1853511681404105_3350720587105304576_o.jpg?_nc_cat=109&ccb=2&_nc_sid=730e14&_nc_ohc=7lTp7KJbIosAX8cW1gs&_nc_ht=scontent-mrs2-1.xx&oh=04364a9154443de1ea8ab787cb7a52bc&oe=60061CA7",
    "https://scontent.fcai1-2.fna.fbcdn.net/v/t31.0-8/27023741_1588978041190805_8535160054054849885_o.jpg?_nc_cat=101&ccb=2&_nc_sid=730e14&_nc_ohc=P_Awg923cR4AX_BP6bv&_nc_ht=scontent.fcai1-2.fna&oh=310eb1435f9003f4690dd5827d6f2751&oe=60070A66",
    "https://scontent.fcai1-2.fna.fbcdn.net/v/t1.0-9/67893856_2323009734454295_9066235581679271936_n.jpg?_nc_cat=102&ccb=2&_nc_sid=8bfeb9&_nc_ohc=eIUkFg2ivdwAX94d-mo&_nc_ht=scontent.fcai1-2.fna&oh=272daf7c74fa5fcde58df6a178ba4fed&oe=6007A462",
  ];
 final List<String> text = [
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
  Widget build(BuildContext context) {final theme = Provider.of<ThemeCustom>(context);
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.isdark == true ? kmaincolor : ksecondcolor,
      appBar: AppBar(backgroundColor:theme.isdark == true ? kmaincolor : ksecondcolor ,

        title: Padding(
          padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
          child: Row(
            children: [
              Center(
                child: Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 22.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pacifico',
                      color: Provider.of<ThemeCustom>(context).isdark == false
                          ? secondtextcolor
                          : textmaincolor),
                ),
              ),
              SizedBox(width: 6,),
              Icon(Icons.category,color: Colors.lightGreen,)
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if(text[index]=='Beef Meals' ||text[index]=='Chicken Meals'||text[index]=='SeaFood Meals')
                    {
                      Navigator.of(context).popAndPushNamed(MeduimLarge.id, arguments: text[index]);
                    }else
                      {
                        Navigator.of(context).pushNamed(CartScreenCat.id, arguments: text[index]);
                      }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        fit: BoxFit.cover,
                        height: _deviceHeight * 0.2,
                        width: _deviceWidth,
                        image: NetworkImage(images[index]),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.09,
                  left: MediaQuery.of(context).size.width * 0.3,
                  child: GestureDetector(
                    onTap: () {
                      if(text[index]=='Beef Meals' ||text[index]=='Chicken Meals'||text[index]=='SeaFood Meals')
                      {
                        Navigator.of(context).popAndPushNamed(MeduimLarge.id, arguments: text[index]);
                      }else
                      {
                        Navigator.of(context).pushNamed(CartScreenCat.id, arguments: text[index]);
                      }

                    },
                    child: Text(
                      text[index],
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 15,
                          )
                        ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
