import 'package:fit/model/product.dart';
import 'package:flutter/material.dart';

class MeduimOrLarge extends StatefulWidget {
  final Product product ;
  final String price02;
  final String protien02;
  final String cals02;
  final String carbs02;
  final String fats02;

  MeduimOrLarge({@required this.product,this.cals02,this.carbs02,this.price02,this.protien02,this.fats02});
  @override


  _MeduimOrLargeState createState() => _MeduimOrLargeState();
}

class _MeduimOrLargeState extends State<MeduimOrLarge> {

  @override
  Widget build(BuildContext context) {

    return Container(
       child:
      Row( crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container( height: 25,width: 100
        ,decoration: BoxDecoration(
color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(20)
            ),
              child: GestureDetector
                (onTap:()
              {
              //    Provider.of<SizeProvider>(context ,listen:false).changeSize(true);



              } ,
                  child: Center(
                    child: Text('150 gm',style: TextStyle(
                        color:
                        Color(0xFF111328)
                        ,fontWeight: FontWeight.bold),),
                  )),
            ),
            SizedBox(width: 20,),
            Container(height: 25,width: 100
                ,decoration: BoxDecoration(
color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(20)),
              child: GestureDetector
                (onTap:()
              {
               // Provider.of<SizeProvider>(context ,listen:false).changeSize(false);

              } ,
                  child: Center(
                    child: Text('250 gm',style: TextStyle(
                        color:
                        Color(0xFF111328)
                        ,fontWeight: FontWeight.bold),),
                  )),
            )
          ],)
    );
  }


}
